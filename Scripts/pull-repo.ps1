<#
.SYNTAX       pull-repo.ps1 [<repo-dir>]
.DESCRIPTION  pulls updates for a local Git repository (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	
	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"🢃 Pulling updates..."
	$Result = (git pull --recurse-submodules --jobs=4)
	if ($lastExitCode -ne "0") {
		if ("$Result" -match "You are not currently on a branch.") {
			"NOTE: not on a branch, nothing to pull"
		} else {
			throw "'git pull' failed" }
		}
	}

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled updates for Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
