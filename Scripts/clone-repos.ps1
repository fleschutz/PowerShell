<#
.SYNOPSIS
	Clones well-known Git repositories into a folder
.DESCRIPTION
	This PowerShell script clones well-known Git repositories into a folder.
.PARAMETER folder
	Specifies the target folder
.EXAMPLE
	PS> ./clone-repos C:\Repos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$FolderPath = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$FolderPath" -pathType container)) { throw "Can't access directory: $FolderPath" }
	$ParentFolderName = (Get-Item "$FolderPath").Name

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Table = import-csv "$PSScriptRoot/../Data/git-repos.csv"
	$NumEntries = $Table.count
	"Found $NumEntries entries in database Data/git-repos.csv..."

	[int]$Step = 0
	[int]$Cloned = 0
	[int]$Skipped = 0
	foreach($Row in $Table) {
		[string]$FolderName = $Row.FolderName
		[string]$Branch = $Row.Branch
		[string]$Shallow = $Row.Shallow
		[string]$URL = $Row.URL
		$Step++

		if (test-path "$FolderPath/$FolderName" -pathType container) {
			"⏳ Step $Step/$($NumEntries): Skipping already existing 📂$($FolderName)..."
			$Skipped++
			continue
		}
		if ($Shallow -eq "yes") {
			"⏳ Step $Step/$($NumEntries): Cloning shallow $Branch branch to 📂$($FolderName)..."
			& git clone --branch "$Branch" --depth 1 --shallow-submodules --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
		} else {
			"⏳ Step $Step/$($NumEntries): Cloning full $Branch branch to 📂$FolderName..."
			& git clone --branch "$Branch" --recurse-submodules "$URL" "$FolderPath/$FolderName"
			if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
		}
		$Cloned++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ $Cloned Git repositories cloned, $Skipped skipped in 📂$ParentFolderName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
