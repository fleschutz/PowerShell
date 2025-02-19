# Requires admin privileges to run
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Host "This script requires administrative privileges." -ForegroundColor Red
	Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Yellow
	pause
	exit 1
}

try {
	Write-Host "Preparing to reboot into BIOS/UEFI..." -foregroundColor Yellow
    
	# Get boot configuration
	$bootConfig = bcdedit /enum firmware
	if ($lastExitCode -ne 0) { throw "Failed to get boot configuration" }

	# Set the one-time boot to UEFI
	$result = shutdown /r /fw /t 0
	if ($lastExitCode -ne 0) { throw "Failed to initiate reboot" }

} catch {
	Write-Host "Error: $_" -ForegroundColor Red
	Write-Host "Failed to initiate BIOS reboot." -ForegroundColor Red
	pause
	exit 1
}