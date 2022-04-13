<#
.SYNOPSIS
	Performs a selftest on your S.M.A.R.T. HDD/SSD devices.
.DESCRIPTION
	This PowerShell script performs a selftest on your S.M.A.R.T. HDD/SSD devices.
        It requires smartctl (smartmontools package) and admin rights.
.PARAMETER type
	Specifies the type of selftest: either short (default) or long
.EXAMPLE
	PS> ./check-smart-devices
	✔️ short selftest started on S.M.A.R.T. device /dev/sda
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

param([string]$type = "short")

try {
	$Result=(smartctl --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'smartctl' - make sure smartmontools are installed" }

	$Devices = $(sudo smartctl --scan-open)
	foreach($Device in $Devices) {
		$Array = $Device.split(" ")
		$Device = $Array[0]
		$Result = (sudo smartctl --test=$type $Device)
		"✔️ $type selftest started on S.M.A.R.T. device $Device"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
