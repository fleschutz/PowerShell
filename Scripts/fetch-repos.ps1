<#
.SYNOPSIS
	Fetches updates into Git repos
.DESCRIPTION
	This PowerShell script fetches updates into all Git repositories in a folder (including submodules).
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./fetch-repos.ps1 C:\MyRepos
	⏳ (1) Searching for Git executable...  git version 2.41.0.windows.3
	⏳ (2) Checking parent folder...        33 subfolders
	⏳ (3/35) Fetching into 📂base256unicode...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Checking parent folder...        " -noNewline
	if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access folder: $ParentDir" }
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	$NumFolders = $Folders.Count
	$ParentDirName = (Get-Item "$ParentDir").Name
	Write-Host "$NumFolders subfolders"

	[int]$Step = 2
	foreach ($Folder in $Folders) {
		$FolderName = (Get-Item "$Folder").Name
		$Step++
		Write-Host "⏳ ($Step/$($NumFolders + 2)) Fetching into 📂$FolderName...  "

		& git -C "$Folder" fetch --all --recurse-submodules --prune --prune-tags --force
		if ($lastExitCode -ne "0") { throw "'git fetch' in $Folder failed with exit code $lastExitCode" }
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Fetching updates into $NumFolders repositories under 📂$ParentDirName took $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
