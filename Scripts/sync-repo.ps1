<#
.SYNOPSIS
	Synchronizes a repo 
.DESCRIPTION
	This PowerShell script synchronizes a local Git repository by push and pull (including submodules).
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./sync-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...  " -noNewline
 	& git --version
 	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/4) Checking local repository...     📂$RepoDir"
	if (!(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }
	$RepoDirName = (Get-Item "$RepoDir").Name

	Write-Host "⏳ (3/4) Pushing local updates...         " -noNewline
	& git -C "$RepoDir" push
	if ($lastExitCode -ne "0") { throw "'git push' failed" }

	Write-Host "⏳ (4/4) Pulling remote updates...        " -noNewline
	& git -C "$RepoDir" pull --all --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ synchronized repo 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
