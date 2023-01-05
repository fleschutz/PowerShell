<#
.SYNOPSIS
	Pulls updates for Git repos
.DESCRIPTION
	This PowerShell script pulls updates for all Git repositories in a folder (including submodules).
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./pull-repos C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...     " -NoNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Checking parent folder...           " -NoNewline
	if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access folder: $ParentDir" }
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	$NumFolders = $Folders.Count
	$ParentDirName = (Get-Item "$ParentDir").Name
	Write-Host "$NumFolders subfolders in 📂$ParentDirName"

	[int]$Step = 3
	[int]$Failed = 0
	foreach ($Folder in $Folders) {
		$FolderName = (Get-Item "$Folder").Name
		Write-Host "⏳ ($Step/$($NumFolders + 2)) Pulling into 📂$FolderName...    " -NoNewline

		& git -C "$Folder" pull --recurse-submodules --jobs=4
		if ($lastExitCode -ne "0") { $Failed++; write-warning "'git pull' in 📂$FolderName failed" }

		& git -C "$Folder" submodule update --init --recursive
		if ($lastExitCode -ne "0") { throw "'git submodule update' in 📂$Folder failed with exit code $lastExitCode" }

		$Step++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled $NumFolders Git repositories in 📂$ParentDirName in $Elapsed sec ($Failed failed)."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
