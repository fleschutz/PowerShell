<#
.SYNOPSIS
	list-submodules.ps1 [<repo-dir>] 
.DESCRIPTION
	Lists the submodules of the current/given Git repository 
.EXAMPLE
	PS> .\list-submodules.ps1 C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
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

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
