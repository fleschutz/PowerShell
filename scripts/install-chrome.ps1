<#
.SYNOPSIS
	Installs Chrome
.DESCRIPTION
	This PowerShell script installs the Google Chrome browser.
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
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	"⏳ Installing Google Chrome from WinGet..."

	& winget install --id Google.Chrome --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "'winget install' failed" }

        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
        "✅ Google Chrome installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
