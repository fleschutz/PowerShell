<#
.SYNOPSIS
	Cleans all Git repositories in a folder from untracked files 
.DESCRIPTION
	This PowerShell script cleans all Git repositories in a folder from untracked files (including submodules).
.PARAMETER parentDir
	Specifies the path to the parent folder (current working dir by default)
.EXAMPLE
	PS> ./clean-repos.ps1 C:\MyRepos
	⏳ (1) Searching for Git executable...    git version 2.47.1
	⏳ (2) Checking parent folder 📂Repos...  28 subfolders found
	⏳ (3/30) Cleaning 📂base256unicode...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...    " -noNewline
        & git --version
        if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

        $parentDirName = (Get-Item "$ParentDir").Name
        Write-Host "⏳ (2) Checking parent folder 📂$parentDirName...  " -noNewline
        if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access folder: $ParentDir" }
        $folders = (Get-ChildItem "$ParentDir" -attributes Directory)
        $numFolders = $folders.Count
        Write-Host "$numFolders subfolders found"

	[int]$Step = 2
	foreach ($folder in $folders) {
		$FolderName = (Get-Item "$folder").Name
		$Step++
		"⏳ ($Step/$($numFolders + 2)) Cleaning 📂$FolderName..."

		& git -C "$folder" clean -xfd -f # force + recurse into dirs + don't use the standard ignore rules
		if ($lastExitCode -ne 0) { throw "'git clean -xfd -f' failed with exit code $lastExitCode" }

		& git -C "$folder" submodule foreach --recursive git clean -xfd -f 
		if ($lastExitCode -ne 0) { throw "'git clean -xfd -f' in submodules failed with exit code $lastExitCode" }
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Cleaned $numFolders Git repositories under 📂$parentDirName in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
