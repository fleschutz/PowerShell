<#
.SYNOPSIS
	Installs GitHub CLI
.DESCRIPTION
	This PowerShell script installs the GitHub command-line interface (CLI).
.EXAMPLE
	PS> ./install-github-cli.ps1
	⏳ Installing GitHub CLI...
	✔ GitHub CLI installed successfully in 17s - to authenticate execute: 'gh auth login'.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	"⏳ Installing GitHub CLI..."
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsMacOS) {
		& brew install gh
	} elseif ($IsLinux) {
		& sudo apt install gh
	} else {
		& winget install --id GitHub.cli
		if ($lastExitCode -ne 0) { throw "Installation of GitHub CLI failed, maybe it's already installed." }
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ GitHub CLI installed successfully in $($elapsed)s - to authenticate execute: 'gh auth login'"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
