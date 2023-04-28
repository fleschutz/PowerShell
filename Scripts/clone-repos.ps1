<#
.SYNOPSIS
	Clones popular repos
.DESCRIPTION
	This PowerShell script clones popular Git repositories into a target directory.
.PARAMETER targetDir
	Specifies the file path to the target directory (current working directory by default)
.EXAMPLE
	PS> ./clone-repos C:\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$TargetDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...          " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Loading Data/popular-git-repos.csv...    " -noNewline
	$Table = Import-CSV "$PSScriptRoot/../Data/popular-git-repos.csv"
	$NumEntries = $Table.count
	Write-Host "$NumEntries Git repos listed"

	$TargetDirName = (Get-Item "$TargetDir").Name
	Write-Host "⏳ (3) Checking target folder...                📂$TargetDirName"
	if (-not(Test-Path "$TargetDir" -pathType container)) { throw "Can't access directory: $TargetDir" }
	
	[int]$Step = 3
	[int]$Cloned = 0
	[int]$Skipped = 0
	foreach($Row in $Table) {
		[string]$FolderName = $Row.FOLDERNAME
		[string]$Category = $Row.CATEGORY
		[string]$Branch = $Row.BRANCH
		[string]$Full = $Row.FULL
		[string]$URL = $Row.URL
		$Step++

		if (Test-Path "$TargetDir/$FolderName" -pathType container) {
			"⏳ ($Step/$($NumEntries + 4)) Skipping existing 📂$FolderName ($Category)..."
			$Skipped++
			continue
		}
		if ($Full -eq "yes") {
			"⏳ ($Step/$($NumEntries + 4)) Cloning into 📂$FolderName ($Category) - $Branch branch with full history..."
			& git clone --branch "$Branch" --recurse-submodules "$URL" "$TargetDir/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		} else {
			"⏳ ($Step/$($NumEntries + 4)) Cloning into 📂$FolderName ($Category) - $Branch branch only..."
			& git clone --branch "$Branch" --single-branch --recurse-submodules "$URL" "$TargetDir/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		}
		$Cloned++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cloned $Cloned of $NumEntries Git repos into folder 📂$TargetDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
