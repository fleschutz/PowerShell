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
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...  " -noNewline
        & git --version
        if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

        $ParentDirName = (Get-Item "$ParentDir").Name
        Write-Host "⏳ (2) Checking parent folder 📂$ParentDirName...  " -noNewline
        if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access folder: $ParentDir" }
        $Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
        $NumFolders = $Folders.Count
        Write-Host "$NumFolders subfolders found"

	[int]$Step = 2
	foreach ($Folder in $Folders) {
		$FolderName = (Get-Item "$Folder").Name
		$Step++
		"⏳ ($Step/$($NumFolders + 2)) Cleaning 📂$FolderName..."

		& git -C "$Folder" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' failed with exit code $lastExitCode" }

		& git -C "$Folder" submodule foreach --recursive git clean -xfd -f 
		if ($lastExitCode -ne "0") { throw "'git clean -xfd -f' in submodules failed with exit code $lastExitCode" }
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cleaned $NumFolders Git repositories at 📂$ParentDirName in $Elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
