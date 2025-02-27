sc create SGMonitoramento9UYEPCFHF7 binpath="C:\SGBR\Master\Monitoramento.exe" start=delayed-auto displayname= "Monitoramento de DF-e e integridade - SGBr Sistemas - 9UYEPCFHF7"
taskkill /f /im monitoramento.exe
SC DELETE SGMonitoramento9UYEPCFHF7