<#
.SYNOPSIS
	Installs GitHub CLI
.DESCRIPTION
	This script installs GitHub command-line interface (CLI).
.EXAMPLE
	PS> ./install-github-cli
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsMacOS) {
		brew install gh
	} elseif ($IsLinux) {
		curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
		sudo apt update
		sudo apt install gh
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ installed GitHub CLI in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
