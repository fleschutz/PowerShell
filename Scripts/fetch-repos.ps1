#!/usr/bin/pwsh
<#
.SYNTAX       fetch-repos.ps1 [<parent-dir>]
.DESCRIPTION  fetches updates for all Git repositories under the current/given directory (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	"Fetching updates for Git repositories under $($ParentDir)..."
	$StartTime = get-date

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }
	set-location $ParentDir

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	[int]$Count = 0
	get-childItem $ParentDir -attributes Directory | foreach-object {
		"Fetching updates for $($_.FullName)..."
		set-location $_.FullName

		& git fetch --all --recurse-submodules
		if ($lastExitCode -ne "0") { throw "'git fetch --all --recurse-submodules' failed" }

		set-location ..
		$Count++
	}

	$Elapsed = new-timeSpan -start $StartTime -end (get-date)
	write-host -foregroundColor green "OK - fetched updates for $Count Git repositories under $ParentDir in $($Elapsed.seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
