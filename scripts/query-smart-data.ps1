<#
.SYNOPSIS
	Queries and saves the S.M.A.R.T. data of your HDD's/SSD's
.DESCRIPTION
	Queries the S.M.A.R.T. data of your HDD/SSD's and saves it to the current/given directory.
	(use smart-data2csv.ps1 to generate a CSV table for analysis).
        Requires smartctl (smartmontools) and admin rights. For automation copy this script to /etc/cron.daily 
.PARAMETER Directory
	Specifies the path to the target directory
.EXAMPLE
	PS> ./query-smart-data
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

param([string]$Directory = "")


function CheckIfInstalled {
	try {
		$null = $(smartctl --version)
	} catch {
		write-error "smartctl is not installed - make sure smartmontools are installed"
		exit 1
	}
}

try {
	if ($Directory -eq "") {
		$Directory = "$PWD"
	}

	write-output "(1) Checking for 'smartctl'..."
	CheckIfInstalled

	write-output "(2) Scanning for S.M.A.R.T. devices..."
	$Devices = $(smartctl --scan-open)

	[int]$DevNo = 1
	foreach($Device in $Devices) {
		write-output "(3) Querying data from S.M.A.R.T. device $Device..."

		$Time = (Get-Date)
		$Filename = "$Directory/SMART-dev$($DevNo)-$($Time.Year)-$($Time.Month)-$($Time.Day).json"
		write-output "(4) Saving data to $Filename..."

		$Cmd = "smartctl --all --json " + $Device 

		Invoke-Expression $Cmd > $Filename
		$DevNo++
	}

	"✅  Done."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
