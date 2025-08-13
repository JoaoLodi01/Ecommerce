package main

import (
	"fmt"
	"log"
	"net"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strconv"
	"strings"
	"sync"
	"syscall"
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/widget"
)

/*
App desktop (Fyne) para gerenciar:
- Front Ecommerce (quasar dev)
- Back Ecommerce (php artisan serve --host=<ip>)
- Front Core (quasar dev -p 9090)
- Back Core (php artisan serve --host=<ip> --port=8080)

Status/Logs por serviço. Start/Stop individuais e Start All/Stop All.
*/

type Service struct {
	Key       string
	Label     string
	Workdir   *widget.Entry
	Cmd       *widget.Entry
	Status    *widget.Label
	PID       int
	Running   bool
	LastError string
}

type Manager struct {
	mu      sync.Mutex
	procs   map[string]*exec.Cmd
	stdouts map[string]*os.File
	stderrs map[string]*os.File
}

func NewManager() *Manager {
	return &Manager{
		procs:   map[string]*exec.Cmd{},
		stdouts: map[string]*os.File{},
		stderrs: map[string]*os.File{},
	}
}

func getLocalIP() string {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		return "127.0.0.1"
	}
	defer conn.Close()
	return conn.LocalAddr().(*net.UDPAddr).IP.String()
}

func dirExists(p string) bool {
	if p == "" {
		return false
	}
	info, err := os.Stat(p)
	return err == nil && info.IsDir()
}

func resolvePath(primary, fallback string) string {
	if dirExists(primary) {
		return primary
	}
	if dirExists(fallback) {
		return fallback
	}
	return primary // deixa o primário; usuário pode corrigir na UI
}

func splitArgs(line string) []string {
	// simples: sem aspas complexas
	parts := strings.Fields(line)
	out := make([]string, 0, len(parts))
	for _, p := range parts {
		if p != "" {
			out = append(out, p)
		}
	}
	return out
}

func (m *Manager) start(s *Service) error {
	m.mu.Lock()
	defer m.mu.Unlock()

	if s.Running {
		return nil
	}

	// Pasta de logs
	if err := os.MkdirAll("logs", 0o755); err != nil {
		return fmt.Errorf("erro criando pasta logs: %w", err)
	}
	stdoutFile, err := os.Create(filepath.Join("logs", fmt.Sprintf("%s_stdout.log", s.Key)))
	if err != nil {
		return fmt.Errorf("stdout: %w", err)
	}
	stderrFile, err := os.Create(filepath.Join("logs", fmt.Sprintf("%s_stderr.log", s.Key)))
	if err != nil {
		_ = stdoutFile.Close()
		return fmt.Errorf("stderr: %w", err)
	}

	cmdline := splitArgs(s.Cmd.Text)
	if len(cmdline) == 0 {
		_ = stdoutFile.Close()
		_ = stderrFile.Close()
		return fmt.Errorf("comando vazio")
	}

	cmd := exec.Command(cmdline[0], cmdline[1:]...)
	cmd.Dir = s.Workdir.Text
	cmd.Stdout = stdoutFile
	cmd.Stderr = stderrFile

	// novo grupo/árvore de processo
	if runtime.GOOS == "windows" {
		cmd.SysProcAttr = &syscall.SysProcAttr{CreationFlags: syscall.CREATE_NEW_PROCESS_GROUP}
	} else {
		cmd.SysProcAttr = &syscall.SysProcAttr{Setpgid: true}
	}

	if err := cmd.Start(); err != nil {
		_ = stdoutFile.Close()
		_ = stderrFile.Close()
		s.LastError = err.Error()
		return err
	}

	m.procs[s.Key] = cmd
	m.stdouts[s.Key] = stdoutFile
	m.stderrs[s.Key] = stderrFile

	s.Running = true
	s.PID = cmd.Process.Pid
	s.LastError = ""
	s.Status.SetText(fmt.Sprintf("Rodando (PID %d)", s.PID))

	log.Printf("[%s] START pid=%d dir=%s cmd=%s\n", s.Key, s.PID, s.Workdir.Text, s.Cmd.Text)
	return nil
}

func (m *Manager) stop(s *Service) {
	m.mu.Lock()
	defer m.mu.Unlock()

	if !s.Running {
		return
	}

	pid := s.PID
	cmd := m.procs[s.Key]

	if runtime.GOOS == "windows" {
		_ = exec.Command("taskkill", "/T", "/F", "/PID", strconv.Itoa(pid)).Run()
	} else {
		if cmd != nil && cmd.Process != nil {
			_ = cmd.Process.Signal(syscall.SIGTERM)
		}
		time.Sleep(500 * time.Millisecond)
		_ = syscall.Kill(-pid, syscall.SIGKILL)
	}

	if f := m.stdouts[s.Key]; f != nil {
		_ = f.Close()
	}
	if f := m.stderrs[s.Key]; f != nil {
		_ = f.Close()
	}
	delete(m.procs, s.Key)
	delete(m.stdouts, s.Key)
	delete(m.stderrs, s.Key)

	s.Running = false
	s.PID = 0
	s.Status.SetText("Parado")
	log.Printf("[%s] STOP\n", s.Key)
}

func (m *Manager) stopAll(services []*Service) {
	for _, s := range services {
		m.stop(s)
	}
}

func main() {
	a := app.New()
	w := a.NewWindow("Painel de Serviços (Go + Fyne)")
	w.Resize(fyne.NewSize(900, 640))

	hostEntry := widget.NewEntry()
	hostEntry.SetText(getLocalIP())
	corePortEntry := widget.NewEntry()
	corePortEntry.SetText("8080")

	// Paths com fallback
	ecommerceFront := resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_Front`,
	)
	ecommerceBack := resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Ecommerce/G2L_BackEnd`,
	)
	coreFront := resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_FrontEnd`,
	)
	coreBack := resolvePath(
		`D:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
		`C:/Gabriel/Projetos/G2L_DevHouse/Core/G2L_Access_BackEnd`,
	)

	// Serviços (UI)
	sFront1 := &Service{
		Key:     "front1",
		Label:   "Frontend Ecommerce (Quasar dev)",
		Workdir: widget.NewEntry(),
		Cmd:     widget.NewEntry(),
		Status:  widget.NewLabel("Parado"),
	}
	sFront1.Workdir.SetText(ecommerceFront)
	sFront1.Cmd.SetText("quasar dev")

	sBack1 := &Service{
		Key:     "back1",
		Label:   "Backend Ecommerce (Laravel serve)",
		Workdir: widget.NewEntry(),
		Cmd:     widget.NewEntry(),
		Status:  widget.NewLabel("Parado"),
	}
	sBack1.Workdir.SetText(ecommerceBack)
	sBack1.Cmd.SetText("php artisan serve --host=" + hostEntry.Text)

	sFront2 := &Service{
		Key:     "front2",
		Label:   "Frontend Core (Quasar dev :9090)",
		Workdir: widget.NewEntry(),
		Cmd:     widget.NewEntry(),
		Status:  widget.NewLabel("Parado"),
	}
	sFront2.Workdir.SetText(coreFront)
	sFront2.Cmd.SetText("quasar dev -p 9090")

	sBack2 := &Service{
		Key:     "back2",
		Label:   "Backend Core (Laravel serve :8080)",
		Workdir: widget.NewEntry(),
		Cmd:     widget.NewEntry(),
		Status:  widget.NewLabel("Parado"),
	}
	sBack2.Workdir.SetText(coreBack)
	sBack2.Cmd.SetText(fmt.Sprintf("php artisan serve --host=%s --port=%s", hostEntry.Text, corePortEntry.Text))

	services := []*Service{sFront1, sBack1, sFront2, sBack2}
	m := NewManager()

	// Botões Start/Stop individuais
	makeRow := func(s *Service) fyne.CanvasObject {
		btnStart := widget.NewButton("Start", func() {
			if err := m.start(s); err != nil {
				s.Status.SetText("Erro: " + err.Error())
			}
		})
		btnStop := widget.NewButton("Stop", func() { m.stop(s) })

		return container.NewVBox(
			widget.NewLabelWithStyle(s.Label, fyne.TextAlignLeading, fyne.TextStyle{Bold: true}),
			widget.NewForm(
				widget.NewFormItem("Pasta", s.Workdir),
				widget.NewFormItem("Comando", s.Cmd),
				widget.NewFormItem("Status", s.Status),
			),
			container.NewHBox(btnStart, btnStop),
			widget.NewSeparator(),
		)
	}

	// Header com Host/Porta + Start All/Stop All + Aplicar
	btnApply := widget.NewButton("Aplicar Host/Porta nos Laravel", func() {
		// Atualiza comandos Laravel com host/port atuais
		sBack1.Cmd.SetText("php artisan serve --host=" + hostEntry.Text)
		sBack2.Cmd.SetText(fmt.Sprintf("php artisan serve --host=%s --port=%s", hostEntry.Text, corePortEntry.Text))
	})
	btnStartAll := widget.NewButton("Start All", func() {
		for _, s := range services {
			if err := m.start(s); err != nil {
				s.Status.SetText("Erro: " + err.Error())
			}
		}
	})
	btnStopAll := widget.NewButton("Stop All", func() { m.stopAll(services) })

	header := container.NewVBox(
		widget.NewLabelWithStyle("Configuração Geral", fyne.TextAlignLeading, fyne.TextStyle{Bold: true}),
		widget.NewForm(
			widget.NewFormItem("Host (Laravel --host)", hostEntry),
			widget.NewFormItem("Porta Core (Laravel --port)", corePortEntry),
		),
		container.NewHBox(btnApply, btnStartAll, btnStopAll),
		widget.NewSeparator(),
	)

	content := container.NewVBox(
		header,
		makeRow(sFront1),
		makeRow(sBack1),
		makeRow(sFront2),
		makeRow(sBack2),
	)

	w.SetContent(container.NewVScroll(content))
	w.ShowAndRun()
}
