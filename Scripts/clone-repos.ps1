<#
.SYNOPSIS
	Clones Git repositories
.DESCRIPTION
	This PowerShell script clones well-known Git repositories into a folder.
.PARAMETER folder
	Specifies the target folder (default is current working directory)
.EXAMPLE
	PS> ./clone-repos C:\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$FolderPath = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2) Loading database table from Data/git-repos.csv...  " -noNewline
	$Table = Import-CSV "$PSScriptRoot/../Data/git-repos.csv"
	$NumEntries = $Table.count
	Write-Host "$NumEntries entries found"

	$ParentFolderName = (Get-Item "$FolderPath").Name
	"⏳ (3) Checking target folder 📂$ParentFolderName..."
	if (-not(Test-Path "$FolderPath" -pathType container)) { throw "Can't access directory: $FolderPath" }
	

	[int]$Step = 3
	[int]$Cloned = 0
	[int]$Skipped = 0
	foreach($Row in $Table) {
		[string]$Group = $Row.GROUP
		[string]$FolderName = $Row.FOLDERNAME
		[string]$Branch = $Row.BRANCH
		[string]$Full = $Row.FULL
		[string]$URL = $Row.URL
		$Step++

		if (Test-Path "$FolderPath/$FolderName" -pathType container) {
			"⏳ ($Step/$($NumEntries + 4)) Skipping 📂$($FolderName), it exists already..."
			$Skipped++
			continue
		}
		if ($Full -eq "yes") {
			"⏳ ($Step/$($NumEntries + 4)) Cloning into 📂$($FolderName) ($Branch branch with full history)..."
			& git clone --branch "$Branch" --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		} else {
			"⏳ ($Step/$($NumEntries + 4)) Cloning $Branch branch into 📂$FolderName..."
			& git clone --branch "$Branch" --single-branch --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		}
		$Cloned++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	if ($Cloned -eq 1) {
		"✔️ 1 Git repository cloned into 📂$ParentFolderName in $Elapsed sec ($Skipped skipped)."
	} else {
		"✔️ $Cloned Git repos cloned into 📂$ParentFolderName in $Elapsed sec ($Skipped skipped)."
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}