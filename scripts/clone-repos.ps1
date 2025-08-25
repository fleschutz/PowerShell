<#
.SYNOPSIS
	Clones Git repos
.DESCRIPTION
	This PowerShell script clones popular Git repositories into a common target directory.
.PARAMETER targetDir
	Specifies the file path to the target directory (current working directory by default)
.EXAMPLE
	PS> ./clone-repos C:\MyRepos
	⏳ (1) Searching for Git executable...       git version 2.46.0.windows.1
	⏳ (2) Reading data/popular-repos.csv...     29 repos
	⏳ (3) Checking target folder...             📂Repos
	⏳ (4/32) Cloning 📂base256 (dev tool) from git@github.com:fleschutz/talk2windows.git (main branch only)...
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$targetDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...       " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Reading data/popular-repos.csv...     " -noNewline
	$table = Import-CSV "$PSScriptRoot/../data/popular-repos.csv"
	$total = $table.count
	Write-Host "$total repos"

	$targetDirName = (Get-Item "$targetDir").Name
	Write-Host "⏳ (3) Checking target folder...             📂$targetDirName"
	if (-not(Test-Path "$targetDir" -pathType container)) { throw "Can't access directory: $targetDir" }
	
	[int]$step = 3
	[int]$cloned = 0
	[int]$skipped = 0
	foreach($row in $table) {
		[string]$folderName = $row.FOLDERNAME
		[string]$category = $row.CATEGORY
		[string]$URL = $row.URL
		[string]$branch = $row.BRANCH
		[string]$shallow = $row.SHALLOW
		$step++

		if (Test-Path "$targetDir/$folderName" -pathType container) {
			"⏳ ($step/$($total + 3)) Skipping 📂$folderName ($category): exists already"
			$skipped++
		} elseif ($shallow -eq "yes") {
			"⏳ ($step/$($total + 3)) Cloning 📂$folderName ($category) from $URL ($branch branch only)..."
			& git clone --branch "$branch" --single-branch --recurse-submodules "$URL" "$targetDir/$folderName"
			if ($lastExitCode -ne 0) { throw "'git clone --branch $branch $URL' failed with exit code $lastExitCode" }
			$cloned++
		} else {
			"⏳ ($step/$($total + 3)) Cloning 📂$folderName ($category) from $URL (full $branch branch)..."
			& git clone --branch "$branch" --recurse-submodules "$URL" "$targetDir/$folderName"
			if ($lastExitCode -ne 0) { throw "'git clone --branch $branch $URL' failed with exit code $lastExitCode" }
			$clone++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Cloned $cloned additional Git repos into 📂$targetDirName in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
