<#
.SYNOPSIS
	Checks the drive space
.DESCRIPTION
	This PowerShell script checks all drives for free space left.
.PARAMETER MinLevel
	Specifies the minimum warning level (10 GB by default)
.EXAMPLE
	PS> ./check-drives
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$MinLevel = 10) # 10 GB minimum

try {
	$Drives = Get-PSDrive -PSProvider FileSystem 
	foreach($Drive in $Drives) {
		$ID = $Drive.Name
		$Details = (Get-PSDrive $ID)
		[int]$Free = $Details.Free / 1GB
 		[int]$Used = $Details.Used / 1GB
		[int]$Total = ($Used + $Free)

		if ($Total -eq 0) {
			"✅ Drive $ID is empty."
		} elseif ($Free -lt $MinLevel) {
			"⚠️ Drive $ID has only $Free GB of $Total GB left to use!"
		} elseif ($Used -lt $Free) {
			"✅ Drive $ID uses $Used GB of $Total GB."
		} else {
			"✅ Drive $ID has $Free GB of $Total GB left."
		}
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}