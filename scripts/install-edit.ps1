<#
.SYNOPSIS
	Installs Edit
.DESCRIPTION
	This PowerShell script installs Microsoft Edit.
.EXAMPLE
	PS> ./install-edit.ps1
	⏳ Installing Microsoft Edit from Microsoft Store...
	✅ Microsoft Edit installed successfully (took 25s).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsLinux) {
		"⏳ Installing Microsoft Edit from Snap Store..."
		& sudo snap install msedit 
		if ($lastExitCode -ne 0) { throw "Can't install Microsoft Edit, is it already installed?" }
	} else {
		"⏳ Installing Microsoft Edit from Microsoft Store..."
		& winget install --id Microsoft.Edit --accept-package-agreements --accept-source-agreements
		if ($lastExitCode -ne 0) { throw "Can't install Microsoft Edit, is it already installed?" }
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Microsoft Edit installed successfully (took $($elapsed)s)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
