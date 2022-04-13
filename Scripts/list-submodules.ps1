<#
.SYNOPSIS
	Lists the submodules in a Git repository
.DESCRIPTION
	This PowerShell script lists the submodules in the given Git repository.
.PARAMETER RepoDir
	Specifies the path to the repository (current working directory by default)
.EXAMPLE
	PS> ./list-submodules C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	"⏳ Step 1/3: Checking requirements... "
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/3: Fetching latest updates... "
	& git -C "$RepoDir" fetch
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	"⏳ Step 3/3: Listing submodules... "
	& git -C "$RepoDir" submodule
	if ($lastExitCode -ne "0") { throw "'git submodule' failed" }

	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
