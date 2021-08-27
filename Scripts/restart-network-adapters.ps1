#Requires -RunAsAdministrator
<#
.SYNOPSIS
	restart-network-adapters.ps1
.DESCRIPTION
	Restarts all local network adapters (needs admin rights)
.INPUTS
	None
.OUTPUTS
	None
.EXAMPLE
	PS> .\restart-network-adapters.ps1
.LINK
	htts://github.com/fleschutz/PowerShell
.NOTES
	Author:        Markus Fleschutz
	Creation Date: 2021-08-27
	License:       CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Get-NetAdapter | Restart-NetAdapter 

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ restarted all local network adapters in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
