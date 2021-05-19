<#
.SYNTAX       clean-repo.ps1 [<repo-dir>]
.DESCRIPTION  cleans a Git repository from untracked files (including submodules, e.g. for a fresh build)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$RepoDirName = (get-item "$RepoDir").Name

	"🧹 Cleaning Git repository 📂$RepoDirName from untracked files..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	
	& git -C "$RepoDir" clean -fdx # force + recurse into dirs + don't use the standard ignore rules
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' failed" }

	& git -C "$RepoDir" submodule foreach --recursive git clean -fdx 
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' in submodules failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned Git repository 📂$RepoDirName in $Elapsed sec."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
