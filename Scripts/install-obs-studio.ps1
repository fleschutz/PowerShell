<#
.SYNOPSIS
	Installs OBS Studio (needs admin rights)
.DESCRIPTION
	This script installs OBS Studio (admin rights are needed).
.EXAMPLE
	PS> ./install-obs-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"Sorry, not supported yet."
	} else {
		winget install obsproject.obsstudio
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed OBS Studio in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
