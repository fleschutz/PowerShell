<#
.SYNOPSIS
	Cleans a Git repository from untracked files (including submodules)
.DESCRIPTION
	This PowerShell script cleans a Git repository from untracked files (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./clean-repo C:\MyRepo
	🧹 Cleaning from untracked files...
	✔️ cleaned Git repository 📂C:\MyRepo in 0 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	
	$RepoDirName = (get-item "$RepoDir").Name
	"🧹 Cleaning from untracked files..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }
	
	& git -C "$RepoDir" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
	if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' failed" }

	& git -C "$RepoDir" submodule foreach --recursive git clean -xfd -f
	if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' in submodules failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
