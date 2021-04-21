#!/usr/bin/pwsh
<#
.SYNTAX       fetch-repos.ps1 [<parent-dir>]
.DESCRIPTION  fetches updates for all Git repositories under the current/given directory (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }
	set-location $ParentDir

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	[int]$Count = 0
	get-childItem $ParentDir -attributes Directory | foreach-object {
		set-location "$($_.FullName)"

		& "$PSScriptRoot/fetch-repo.ps1"
		if ($lastExitCode -ne "0") { throw "Script 'fetch-repo.ps1' failed" }

		set-location ..
		$Count++
	}

	[int]$Elapsed = $StopWatch.TotalSeconds
	"✔️ updated $Count Git repositories at 📂$ParentDir in $Elapsed sec."
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
