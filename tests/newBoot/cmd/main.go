package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"syscall"

	"g2l.boot/internal"
)

type Proc struct {
	Name string
	Cmd *exec.Cmd

}

const (
	HOST = internal.GetLocalIP()
)

func dirExists(p string) bool {
	if p == "" {
		return  false
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
		return "", fmt.Errorf("Caminhos não encontrados")
	}
}

func runBackground(ctx context.Context, name, workdir, exe string, args ...string) (*Proc, error) {
	cmd := exec.CommandContext(ctx, exe, args...)

	cmd.Dir = workdir

	logDir := "logs"

	_ = os.Mkdir(logDir, 0o755)

	stdoutFile, err := os.Create(filepath.Join(logDir, fmt.Sprintf("%s_stdout.log", name)))

	if err != nil {
		return nil, fmt.Errorf("[%s] erro criando stdout.log: %w", name, err)

	}

	stderrFile, err := os.Create(filepath.Join(logDir, fmt.Sprintf("%s_stderr.log", name)))

	if err != nil {
		return nil, fmt.Errorf("[%s] erro criando stderr.log: %w", name, err)

	}

	cmd.Stdout = stdoutFile
	cmd.Stderr = stderrFile

	if runtime.GOOS == "windows" {
		cmd.SysProcAttr = &syscall.SysProcAttr{CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP}
	}

	if err := cmd.Start(); err != nil {
		_ = stdoutFile.Close()
		_ = stderrFile.Close()

		return nil, fmt.Errorf("[%s] falha ao iniciar %w", name, err)
	}

	log.Printf("[%s] iniciando (PID=%d) em '%s' -> %s %v\n", name, cmd.Process.Pid, workdir, exe, args)
	return &Proc{Name: name, Cmd: cmd}, nil
}

func main() {
	
}
