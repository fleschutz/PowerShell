<#
.SYNOPSIS
	Cleans all Git repositories in a folder from untracked files 
.DESCRIPTION
	This PowerShell script cleans all Git repositories in a folder from untracked files (including submodules).
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./clean-repos C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$FolderCount = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $FolderCount subfolders in 📂$ParentDirName, cleaning them from untracked files..."

	[int]$Step = 1
	foreach ($Folder in $Folders) {
		$FolderName = (get-item "$Folder").Name
		"⏳ Step $Step/$($FolderCount): Cleaning 📂$FolderName..."

		& git -C "$Folder" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' failed with exit code $lastExitCode" }

		& git -C "$Folder" submodule foreach --recursive git clean -xfd -f 
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' in submodules failed with exit code $lastExitCode" }

		$Step++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned $FolderCount Git repositories at 📂$ParentDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
