<#
.SYNOPSIS
	Clones Repositories
.DESCRIPTION
	This PowerShell script clones well-known Git repositories into a folder.
.PARAMETER folder
	Specifies the target folder
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

	"⏳ Checking requirements..."
	if (-not(test-path "$FolderPath" -pathType container)) { throw "Can't access directory: $FolderPath" }
	$ParentFolderName = (Get-Item "$FolderPath").Name

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Table = import-csv "$PSScriptRoot/../Data/git-repos.csv"
	$NumEntries = $Table.count
	"Found $NumEntries entries in Data/git-repos.csv."

	[int]$Step = 0
	[int]$Cloned = 0
	[int]$Skipped = 0
	foreach($Row in $Table) {
		[string]$FolderName = $Row.FolderName
		[string]$Branch = $Row.Branch
		[string]$Full = $Row.Full
		[string]$URL = $Row.URL
		$Step++

		if (test-path "$FolderPath/$FolderName" -pathType container) {
			"⏳ Step $Step/$($NumEntries) - Skipping 📂$($FolderName) (exists already)..."
			$Skipped++
			continue
		}
		if ($Full -eq "yes") {
			"⏳ Step $Step/$($NumEntries) - Cloning into 📂$($FolderName) ($Branch branch with full history)..."
			& git clone --branch "$Branch" --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		} else {
			"⏳ Step $Step/$($NumEntries) - Cloning into 📂$FolderName ($Branch branch only)..."
			& git clone --branch "$Branch" --single-branch --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone --branch $Branch $URL' failed with exit code $lastExitCode" }
		}
		$Cloned++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	if ($Cloned -eq 1) {
		"✔️ $Cloned repo cloned into 📂$ParentFolderName ($Skipped skipped) in $Elapsed sec"
	} else {
		"✔️ $Cloned repos cloned into 📂$ParentFolderName ($Skipped skipped) in $Elapsed sec"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}