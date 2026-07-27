<#
.SYNOPSIS
	Lists submodules in a Git repository
.DESCRIPTION
	This PowerShell script lists all submodules recursively in the given Git repository.
.PARAMETER RepoDir
	Specifies the path to the repository (current working directory by default)
.EXAMPLE
	PS> ./list-submodules.ps1 C:\MyRepo

	COMMIT ID                                PATH (CURRENT HEAD)
	---------                                -------------------
	9f8bce66f9d170ec26cd9d8c2320740eaf4a3f57 libSI (v1.0-30-g9f8bce6)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }

	""
	" COMMIT ID                                PATH (CURRENT HEAD)"
	" ---------                                -------------------"
	& git -C "$RepoDir" submodule status --recursive
	if ($lastExitCode -ne 0) { throw "'git submodule status' failed" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
