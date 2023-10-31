<#
.SYNOPSIS
	Uninstalls One Calendar
.DESCRIPTION
	This PowerShell script uninstalls One Calendar from the local computer.
.EXAMPLE
	PS> ./uninstall-one-calendar.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling One Calendar ..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget uninstall "One Calendar"
	if ($lastExitCode -ne "0") { throw "Can't uninstall One Calendar, is it installed?" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Removal of One Calendar tool $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}