<#
.SYNOPSIS
	Installs OBS Studio
.DESCRIPTION
	This PowerShell script installs OBS Studio from Microsoft Store.
.EXAMPLE
	PS> ./install-obs-studio.ps1
	⏳ Installing OBS from Microsoft Store...
	✅ OBS installed successfully in 25s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1 

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	"⏳ Installing OBS Studio from Microsoft Store..."

	if ($IsLinux -or $IsMacOS) {
		"Sorry, not supported yet."
	} else {
		& winget install --id XPFFH613W8V6LV 
		if ($lastExitCode -ne 0) { throw "Can't install OBS, is it already installed?" }
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ OBS Studio installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
