#!/usr/bin/pwsh
<#
.SYNTAX       build-repos.ps1 [<parent-dir>]
.DESCRIPTION  builds all Git repositories under the current/given directory
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	"Building Git repositories under $($ParentDir)..."
	$StartTime = get-date

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }
	set-location $ParentDir

	[int]$Count = 0
	get-childItem $ParentDir -attributes Directory | foreach-object {
		& "$PSScriptRoot/build-repo.ps1" "$($_.FullName)"
		if ($lastExitCode -ne "0") { throw "Script 'build-repo.ps1' failed" }

		$Count++
	}

	$Elapsed = new-timeSpan -start $StartTime -end (get-date)
	write-host -foregroundColor green "OK - built $Count Git repositories under $ParentDir in $($Elapsed.seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
