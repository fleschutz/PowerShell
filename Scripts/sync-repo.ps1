<#
.SYNOPSIS
	Synchronizes a Git repository 
.DESCRIPTION
	This PowerShell script synchronizes a Git repository by push & pull (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./sync-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	$RepoDirName = (Get-Item "$RepoDir").Name

	"⏳ Synchronizing Git repository 📂$RepoDirName ..."

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git push
	if ($lastExitCode -ne "0") { throw "'git push' failed" }

	& git pull --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	"✔️ synchronized Git repository 📂$RepoDirName"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
