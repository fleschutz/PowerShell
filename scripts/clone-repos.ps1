<#
.SYNOPSIS
	Clones Git repos
.DESCRIPTION
	This PowerShell script clones popular Git repositories into a common target directory.
.PARAMETER targetDir
	Specifies the file path to the target directory (current working directory by default)
.EXAMPLE
	PS> ./clone-repos C:\MyRepos
	...
	✔️ Cloned 29 of 29 Git repos into 📂MyRepos in 123 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$targetDir = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...          " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Reading data/popular-repositories.csv... " -noNewline
	$table = Import-CSV "$PSScriptRoot/../data/popular-repositories.csv"
	$total = $table.count
	Write-Host "$total repos"

	$targetDirName = (Get-Item "$targetDir").Name
	Write-Host "⏳ (3) Checking target folder...                📂$targetDirName"
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
			"⏳ ($step/$($total + 4)) Skipping existing 📂$folderName (a $category)..."
			$skipped++
		} elseif ($shallow -eq "yes") {
			"⏳ ($step/$($total + 4)) Cloning into 📂$folderName (a $category, $branch branch, shallow)..."
			& git clone --branch "$branch" --single-branch --recurse-submodules "$URL" "$targetDir/$folderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $branch $URL' failed with exit code $lastExitCode" }
			$cloned++
		} else {
			"⏳ ($step/$($total + 4)) Cloning into 📂$folderName (a $category, $branch branch, full history)..."
			& git clone --branch "$branch" --recurse-submodules "$URL" "$targetDir/$folderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $branch $URL' failed with exit code $lastExitCode" }
			$clone++
		}
	}
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Cloned $cloned of $total Git repos into 📂$targetDirName in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
