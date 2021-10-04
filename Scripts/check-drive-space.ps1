<#
.SYNOPSIS
	check-drive-space.ps1 [<drive>] [<min-level>]
.DESCRIPTION
	Checks a drive for free space left (20 GB by default)
.EXAMPLE
	PS> ./check-drive-space C
	✔️ 172 GB left on drive C (61 of 233 GB used)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$Drive = "", [int]$MinLevel = 20) # minimum level in GB

try {
	if ($Drive -eq "" ) { $Drive = read-host "Enter drive to check" }

	$DriveDetails = (get-psdrive $Drive)
	[int]$Free = (($DriveDetails.Free / 1024) / 1024) / 1024
	[int]$Used = (($DriveDetails.Used / 1024) / 1024) / 1024
	[int]$Total = ($Used + $Free)

	if ($Free -lt $MinLevel) {
        	write-warning "Drive $Drive has only $Free GB left to use! ($Used of $Total GB used, minimum is $MinLevel GB)"
		exit 1
	}
	"✔️ $Free GB left on drive $Drive ($Used of $Total GB used)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
