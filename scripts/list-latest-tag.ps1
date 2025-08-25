<#
.SYNOPSIS
	Lists the repo's latest tag
.DESCRIPTION
	This PowerShell script lists the latest tag in a local Git repository.
.PARAMETER RepoDir
	Specifies the path to the local repository (current working dir by default)
.EXAMPLE
	PS> ./list-latest-tag.ps1 C:\MyRepo
	✅ Tag 'v1.0' at commit 4833ecbf1457dc86ad7f4d6e3 ('Version 1.0 released')
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	$LatestTagCommit = (git -C "$RepoDir" rev-list --tags --max-count=1)
	$LatestTagName = (git -C "$RepoDir" describe --tags $LatestTagCommit)
	$LatestTagMessage  = (git -C "$RepoDir" log --format=%B -n 1 $LatestTagCommit)

	"✅ Tag '$LatestTagName' at commit $LatestTagCommit ('$LatestTagMessage')"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
