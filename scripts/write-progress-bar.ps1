$progressBar = @('⣾','⣽','⣻','⢿','⡿','⣟','⣯','⣷')
    
for ([int]$i = 0; $i -lt 150; $i++) {
	Write-Host "`r$($progressBar[$i % 7]) Working on something..." -NoNewline
	Start-Sleep -milliseconds 100
}
exit 0 # success
