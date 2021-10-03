<#
.SYNOPSIS
	check-smart-devices.ps1 
.DESCRIPTION
	Performs a short selftest on your S.M.A.R.T. HDD/SSD devices.
        Requires smartctl (smartmontools) and admin rights.
.EXAMPLE
	PS> ./check-smart-devices
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	"Step 1/4: Checking for 'smartctl'..."
	$Result=(smartctl --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'smartctl' - make sure smartmontools are installed" }

	"Step 2/4: Scanning for S.M.A.R.T. devices..."
	$Devices = $(sudo smartctl --scan-open)

	foreach($Device in $Devices) {
		$Array = $Device.split(" ")
		$Device = $Array[0]
		"Step 3/4: Starting short selftest on device $Device..."
		& sudo smartctl --test=short $Device 
	}

	"✔️ Done."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
