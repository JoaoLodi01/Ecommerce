package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"runtime"
	"strconv"
	"syscall"
	"time"

	"g2l.boot/internal"
)

type Proc struct {
	Name       string
	Cmd        *exec.Cmd
	StdoutFile *os.File
	StderrFile *os.File
}

func dirExists(p string) bool {
	if p == "" {
		return false
	}
	info, err := os.Stat(p)
	return err == nil && info.IsDir()
}

func resolvePath(primary, fallback string) (string, error) {
	switch {
	case dirExists(primary):
		return primary, nil
	case dirExists(fallback):
		return fallback, nil
	default:
		return "", fmt.Errorf("caminhos não encontrados: '%s' e '%s'", primary, fallback)
	}
}

func runBackground(ctx context.Context, name, workdir, exe string, args ...string) (*Proc, error) {
	cmd := exec.CommandContext(ctx, exe, args...)
	cmd.Dir = workdir

	// Logs
	logDir := "logs"
	if err := os.MkdirAll(logDir, 0o755); err != nil {
		return nil, fmt.Errorf("[%s] erro criando pasta de logs: %w", name, err)
	}

	stdoutFile, err := os.Create(filepath.Join(logDir, fmt.Sprintf("%s_stdout.log", name)))
	if err != nil {
		return nil, fmt.Errorf("[%s] erro criando stdout.log: %w", name, err)
	}
	stderrFile, err := os.Create(filepath.Join(logDir, fmt.Sprintf("%s_stderr.log", name)))
	if err != nil {
		_ = stdoutFile.Close()
		return nil, fmt.Errorf("[%s] erro criando stderr.log: %w", name, err)
	}

	cmd.Stdout = stdoutFile
	cmd.Stderr = stderrFile

	// Novo grupo (ajuda a matar árvore em Unix; no Windows usamos taskkill)
	if runtime.GOOS == "windows" {
		cmd.SysProcAttr = &syscall.SysProcAttr{CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP}
	} else {
		cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
	}

	if err := cmd.Start(); err != nil {
		_ = stdoutFile.Close()
		_ = stderrFile.Close()
		return nil, fmt.Errorf("[%s] falha ao iniciar: %w", name, err)
	}

	log.Printf("[%s] iniciado (PID=%d) em '%s' → %s %v\n", name, cmd.Process.Pid, workdir, exe, args)
	return &Proc{Name: name, Cmd: cmd, StdoutFile: stdoutFile, StderrFile: stderrFile}, nil
}

func stopProc(p *Proc) {
	if p == nil || p.Cmd == nil || p.Cmd.Process == nil {
		return
	}

	pid := p.Cmd.Process.Pid

	// Tenta terminar suavemente (Unix)
	if runtime.GOOS != "windows" {
		_ = p.Cmd.Process.Signal(syscall.SIGTERM)
		time.Sleep(500 * time.Millisecond)
		// Mata o grupo de processos
		_ = syscall.Kill(-pid, syscall.SIGKILL)
	} else {
		// Windows: mata árvore de processos
		_ = exec.Command("taskkill", "/T", "/F", "/PID", strconv.Itoa(pid)).Run()
	}

	// Fecha os logs
	if p.StdoutFile != nil {
		_ = p.StdoutFile.Close()
	}
	if p.StderrFile != nil {
		_ = p.StderrFile.Close()
	}
}

func mustResolvePaths() (frontend1, api1, frontend2, api2 string) {
	var err error

	frontend1, err = resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
	)
	checkErrFatal("frontend_path_1", err)

	api1, err = resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
	)
	checkErrFatal("api_path_1", err)

	frontend2, err = resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
	)
	checkErrFatal("frontend_path_2", err)

	api2, err = resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
	)
	checkErrFatal("api_path_2", err)

	return
}

func main() {
	log.SetFlags(log.LstdFlags | log.Lmicroseconds)

	// Descobre o HOST em runtime (sem const)
	host := internal.GetLocalIP()
	// Se GetLocalIP() retornar net.IP, use: host := internal.GetLocalIP().String()

	frontend1, api1, frontend2, api2 := mustResolvePaths()

	// Contexto cancelável + captura de sinais
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, os.Interrupt)
	if runtime.GOOS != "windows" {
		signal.Notify(sigCh, syscall.SIGTERM)
	}

	// Sobe os processos
	var procs []*Proc

	p1, err := runBackground(ctx, "quasar_front_1", frontend1, "quasar", "dev")
	checkErrFatal("quasar_front_1", err)
	procs = append(procs, p1)

	p2, err := runBackground(ctx, "laravel_api_1", api1, "php", "artisan", "serve", "--host="+host)
	checkErrFatal("laravel_api_1", err)
	procs = append(procs, p2)

	p3, err := runBackground(ctx, "quasar_front_2", frontend2, "quasar", "dev", "-p", "9090")
	checkErrFatal("quasar_front_2", err)
	procs = append(procs, p3)

	p4, err := runBackground(ctx, "laravel_api_2", api2, "php", "artisan", "serve", "--host="+host, "--port=8080")
	checkErrFatal("laravel_api_2", err)
	procs = append(procs, p4)

	log.Println("Todos os serviços foram iniciados. Logs em ./logs/*.log")
	log.Println("Pressione CTRL+C para encerrar todos.")

	// Espera sinal e encerra tudo
	<-sigCh
	log.Println("\nEncerrando processos...")
	for _, p := range procs {
		stopProc(p)
	}
	time.Sleep(500 * time.Millisecond)
	log.Println("Finalizado.")
}

func checkErrFatal(label string, err error) {
	if err != nil {
		log.Fatalf("[%s] %v", label, err)
	}
}
