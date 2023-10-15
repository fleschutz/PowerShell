<#
.SYNOPSIS
	Pulls updates into Git repos
.DESCRIPTION
	This PowerShell script pulls updates into all Git repositories in a folder (including submodules).
.PARAMETER parentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./pull-repos C:\MyRepos
	⏳ (1) Searching for Git executable...       git version 2.42.0
	⏳ (2) Checking parent folder...             33 subfolders
	⏳ (3/35) Pulling into 📂base256unicode...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...`t`t" -NoNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Checking parent folder...`t`t" -NoNewline
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access folder: $parentDir" }
	$folders = (Get-ChildItem "$parentDir" -attributes Directory)
	$numFolders = $folders.Count
	$parentDirName = (Get-Item "$parentDir").Name
	Write-Host "$numFolders subfolders"

	[int]$step = 3
	[int]$failed = 0
	foreach ($folder in $folders) {
		$folderName = (Get-Item "$folder").Name
		Write-Host "⏳ ($step/$($numFolders + 2)) Pulling into 📂$folderName...`t`t" -NoNewline

		& git -C "$folder" pull --recurse-submodules --jobs=4
		if ($lastExitCode -ne "0") { $failed++; write-warning "'git pull' in 📂$folderName failed" }

		& git -C "$folder" submodule update --init --recursive
		if ($lastExitCode -ne "0") { throw "'git submodule update' in 📂$folder failed with exit code $lastExitCode" }
		$step++
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Pulled updates into $numFolders repos under 📂$parentDirName ($failed failed, took $elapsed sec)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
