<#
.SYNOPSIS
	Lists the submodules of a Git repository
.DESCRIPTION
	This PowerShell script lists the submodules of the given Git repository.
.PARAMETER RepoDir
	Specifies the path to the repository (current working dir by default)
.EXAMPLE
	PS> ./list-submodules C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git submodule
	if ($lastExitCode -ne "0") { throw "'git submodule' failed" }

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
