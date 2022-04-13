<#
.SYNOPSIS
	Installs OBS Studio (needs admin rights)
.DESCRIPTION
	This PowerShell script installs OBS Studio (admin rights are needed).
.EXAMPLE
	PS> ./install-obs-studio
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
