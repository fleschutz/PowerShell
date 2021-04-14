#!/usr/bin/pwsh
<#
.SYNTAX       pull-repos.ps1 [<parent-dir>]
.DESCRIPTION  pulls updates for all Git repositories under the current/given directory (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	"Pulling updates for Git repositories under $ParentDir ..."
	$StartTime = get-date

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }
	set-location "$ParentDir"

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	[int]$Count = 0
	get-childItem $ParentDir -attributes Directory | foreach-object {
		"Pulling Git repository $($_.FullName)..."

		set-location $_.FullName

		& git pull --recurse-submodules
		if ($lastExitCode -ne "0") { throw "'git pull --recurse-submodules' failed" }

		set-location ..
		$Count++
	}

	$StopTime = get-date
	$TimeSpan = new-timeSpan -start $StartTime -end $StopTime
	write-host -foregroundColor green "OK - pulled updates for $Count Git repositories under $ParentDir in $($TimeSpan.seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
