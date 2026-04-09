<#
.SYNOPSIS
	Installs Chrome
.DESCRIPTION
	This PowerShell script installs the Google Chrome browser from WinGet.
.EXAMPLE
	PS> ./install-chrome.ps1
	⏳ Installing Google Chrome from WinGet...
 	✅ Google Chrome installed successfully in 29s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	"⏳ Installing Google Chrome from WinGet..."
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	& winget install --id Google.Chrome --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "Can't install Google Chrome - maybe it's already installed" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Google Chrome installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
