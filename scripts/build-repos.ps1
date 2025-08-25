<#
.SYNOPSIS
	Builds Git repositories
.DESCRIPTION
	This PowerShell script builds all Git repositories in a folder.
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./build-repos.ps1 C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$ParentDirName = (Get-Item "$ParentDir").Name
	"⏳ Step 1 - Checking parent folder 📂$ParentDirName..."
	if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access folder: $ParentDir" }
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	$FolderCount = $Folders.Count
	"Found $FolderCount subfolders."

	[int]$Step = 1
	foreach ($Folder in $Folders) {
		& "$PSScriptRoot/build-repo.ps1" "$Folder"
		$Step++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Built $FolderCount Git repositories at 📂$ParentDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
