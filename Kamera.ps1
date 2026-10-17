$port = New-Object System.IO.Ports.SerialPort
$port.PortName = "COM4"
$port.BaudRate = 115200
$port.NewLine = "`n"
$port.ReadTimeout = 1000

$kamera = "C:\Users\User\Desktop\KameraShortcut.lnk"
$wshell = New-Object -ComObject WScript.Shell

try {
    $port.Open()
    Write-Host "Verbunden! Warte auf OPEN oder FOTO..." -ForegroundColor Green

    while ($true) {
        try {
            $line = $port.ReadLine().Trim()

            # PIN 13: Kamera öffnen
            if ($line -eq "OPEN") {
                Write-Host "OPEN empfangen!" -ForegroundColor Cyan

                if (Test-Path -LiteralPath $kamera) {
                    Invoke-Item -LiteralPath $kamera
                    Write-Host "Kamera wird geöffnet!" -ForegroundColor Green
                }
                else {
                    Write-Host "Datei nicht gefunden: $kamera" -ForegroundColor Red
                }
            }
            # PIN 14: Foto auslösen
            elseif ($line -eq "FOTO") {
                Write-Host "FOTO empfangen!" -ForegroundColor Cyan

                Start-Sleep -Milliseconds 500
                $wshell.SendKeys(" ")

                Write-Host "Leertaste gesendet!" -ForegroundColor Green
            }
        }
        catch [System.TimeoutException] {
            # Weiter warten
        }
    }
}
finally {
    if ($port.IsOpen) {
        $port.Close()
    }
}