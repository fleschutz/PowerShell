<#
.SYNOPSIS
	Uninstalls GitHub CLI
.DESCRIPTION
	This PowerShell script uninstalls the GitHub CLI from the local computer.
.EXAMPLE
	PS> ./uninstall-github-cli.ps1
	⏳ Uninstalling GitHub CLI...
	✔️ Removal of GitHub CLI took 7 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ Uninstalling GitHub CLI..."
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if ($IsMacOS) {
		& brew uninstall gh
	} elseif ($IsLinux) {
		& sudo apt remote gh
	} else {
		& winget uninstall --id GitHub.cli
	}
	if ($lastExitCode -ne "0") { throw "Can't uninstall GitHub CLI, is it installed?" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Removal of GitHub CLI took $Elapsed sec"
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}
