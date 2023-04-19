<#
.SYNOPSIS
	Fetches Git repo updates
.DESCRIPTION
	This PowerShell script fetches the latest updates into a local Git repository (including submodules).
.PARAMETER RepoDir
	Specifies the file path to the local Git repository (default is working directory).
.EXAMPLE
	PS> ./fetch-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/3) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/3) Checking repository...           📂$RepoDir"
	if (!(Test-Path "$RepoDir" -pathType container)) { throw "Can't access folder: $RepoDir" }
	$RepoDirName = (Get-Item "$RepoDir").Name

	Write-Host "⏳ (3/3) Fetching updates... "
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force 
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }
	
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ fetched updates into repo 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}