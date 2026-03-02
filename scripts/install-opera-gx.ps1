<#
.SYNOPSIS
	Installs Opera GX
.DESCRIPTION
	This PowerShell script installs the Opera GX gaming-browser from Microsoft Store.
.EXAMPLE
	PS> ./install-opera-gx.ps1
	⏳ Installing Opera GX from Microsoft Store...
        ✅ Opera GX installed successfully in 25s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	"⏳ Installing Opera GX from Microsoft Store..."

	& winget install --id XPDBZ4MPRKNN30 --source msstore --accept-package-agreements --accept-source-agreements
	if ($lastExitCode -ne 0) { throw "Can't install Opera GX - maybe it's already installed" }

        [int]$elapsed = $stopWatch.Elapsed.TotalSeconds
        "✅ Opera GX installed successfully in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
