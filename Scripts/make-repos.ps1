<#
.SYNOPSIS
	make-repos.ps1 [<parent-dir>]
.DESCRIPTION
	Builds all Git repositories under the current/given directory
.EXAMPLE
	PS> .\make-repos.ps1 C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$FolderCount = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $FolderCount subfolders in 📂$ParentDirName..."

	[int]$Step = 1
	foreach ($Folder in $Folders) {
		& "$PSScriptRoot/make-repo.ps1" "$Folder"
		$Step++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ built $FolderCount Git repositories at 📂$ParentDirName in $Elapsed sec"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
