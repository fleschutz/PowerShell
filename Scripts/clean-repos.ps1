<#
.SYNOPSIS
	clean-repos.ps1 [<ParentDir>]
.DESCRIPTION
	Cleans all Git repositories under the current/given directory from untracked files (including submodules)
.EXAMPLE
	PS> ./clean-repos C:\MyRepos
.NOTES
	Author: Markus Fleschutz · License: CC0
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
	$FolderCount = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $FolderCount subfolders in 📂$ParentDirName, cleaning from untracked files..."

	[int]$Step = 1
	foreach ($Folder in $Folders) {
		$FolderName = (get-item "$Folder").Name
		"👉 Step $Step/$($FolderCount): Cleaning 📂$($FolderName)..."

		& git -C "$Folder" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' failed" }

		& git -C "$Folder" submodule foreach --recursive git clean -xfd -f 
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' in submodules failed" }

		$Step++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned $FolderCount Git repositories at 📂$ParentDirName in $Elapsed sec"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
