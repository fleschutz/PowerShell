<#
.SYNOPSIS
	Pulls updates for all Git repositories in a folder
.DESCRIPTION
	This PowerShell script pulls updates for all Git repositories in a folder (including submodules).
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./pull-repos C:\MyRepos
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$NumFolders = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $NumFolders subfolders in 📂$ParentDirName... "

	[int]$Step = 1
	foreach ($Folder in $Folders) {
		$FolderName = (get-item "$Folder").Name
		"⏳ Step $Step/$($NumFolders): Pulling 📂$FolderName... "

		& git -C "$Folder" pull --recurse-submodules --jobs=4
		if ($lastExitCode -ne "0") { write-warning "'git pull' in 📂$FolderName failed" }

		& git -C "$Folder" submodule update --init --recursive
		if ($lastExitCode -ne "0") { throw "'git submodule update' in 📂$FolderName failed" }

		$Step++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ pulled $NumFolders Git repositories at 📂$ParentDirName in $Elapsed sec "
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
