<#
.SYNOPSIS
	Checks the free space of all drives
.DESCRIPTION
	This PowerShell script checks all drives for free space left (20 GB by default).
.EXAMPLE
	PS> ./check-drives
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Drives = Get-PSDrive -PSProvider FileSystem 
	foreach($Drive in $Drives) {
		$DriveDetails = (Get-PSDrive $Drive.Name)
		[int]$Free = (($DriveDetails.Free / 1024) / 1024) / 1024
		[int]$Used = (($DriveDetails.Used / 1024) / 1024) / 1024
		[int]$Total = ($Used + $Free)

		if ($Total -eq "0") {
			$Reply = "Drive $($Drive.Name) is empty."
		} elseif ($Free -lt $MinLevel) {
			$Reply = "Drive $($Drive.Name) has only $Free GB left to use! $Used of $Total GB is in use."
		} else {
			$Reply = "Drive $($Drive.Name) has $($Free) GB left, $($Total) GB total."
		}
		"* $Reply"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}