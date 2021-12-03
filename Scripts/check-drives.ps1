<#
.SYNOPSIS
	Checks all drives for free space left (20 GB by default)
.DESCRIPTION
	This script checks all drives for free space left (20 GB by default).
.PARAMETER MinLevel
	Specifies the minimum level in Gigabyte
.EXAMPLE
	PS> ./check-drives
	✔️ Drive C has 172G left (233G total)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([int]$MinLevel = 20) # minimum level in GB

try {
	$Drives = Get-PSDrive -PSProvider FileSystem 
	foreach($Drive in $Drives) {
		$DriveDetails = (Get-PSDrive $Drive.Name)
		[int]$Free = (($DriveDetails.Free / 1024) / 1024) / 1024
		[int]$Used = (($DriveDetails.Used / 1024) / 1024) / 1024
		[int]$Total = ($Used + $Free)

		if ($Free -lt $MinLevel) {
			$Reply = "Drive $($Drive.Name) has only $Free GB left to use! ($Used of $Total GB used, minimum is $MinLevel GB)"
		} else {
			$Reply = "Drive $($Drive.Name) has $($Free)G left ($($Total)G total)"
		}
		"✔️ $Reply"
		& "$PSScriptRoot/speak-english.ps1" "$Reply"
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
