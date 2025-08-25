<#
.SYNOPSIS
	Checks Git repositories
.DESCRIPTION
	This PowerShell script verifies the data integrity of all Git repositories in a folder.
.PARAMETER parentDir
	Specifies the file path to the parent folder
.EXAMPLE
	PS> ./check-repos.ps1 C:\Repos
	⏳ Checking parent folder 📂C:\Repos...    16 subfolders
	⏳ Checking repo 'rust' (1/16)...
	...
	✅ 16 Git repos checked at 📂C:\Repos in 356s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	$parentDirName = (Get-Item "$parentDir").Name
	Write-Host "⏳ Checking parent folder 📂$parentDir...       " -noNewline
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access folder: $parentDir" }
	$folders = (Get-ChildItem "$parentDir" -attributes Directory)
	$numFolders = $folders.Count
	"$numFolders subfolders"

	[int]$step = 1
	foreach ($folder in $folders) {
		"`n⏳ Checking repo '$folder' ($step/$numFolders)..."
		& "$PSScriptRoot/check-repo.ps1" "$folder"
		$step++
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ $numFolders Git repos checked at 📂$parentDir in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
