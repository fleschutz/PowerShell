$progressBar = @('⣾','⣽','⣻','⢿','⡿','⣟','⣯','⣷')
$progressIndex = 0
    
do {
	Write-Host "`r$($progressBar[$progressIndex]) Working on something..." -NoNewline
	$progressIndex = ($progressIndex + 1) % $progressBar.Length
	Start-Sleep -milliseconds 100
} while ($true)