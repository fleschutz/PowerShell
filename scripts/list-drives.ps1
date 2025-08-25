<#
.SYNOPSIS
	Lists all drives
.DESCRIPTION
	This PowerShell script lists all local drives as a table.
.EXAMPLE
	PS> ./list-drives.ps1

	DriveLetter FriendlyName     FileSystemType DriveType HealthStatus OperationalStatus SizeRemaining      Size
	----------- ------------     -------------- --------- ------------ ----------------- -------------      ----
	C           SSD              NTFS           Fixed     Healthy      OK                    449.65 GB 930.43 GB
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Volume
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
