#!/usr/bin/pwsh
<#
.SYNTAX       clone-repos.ps1 [<parent-dir>]
.DESCRIPTION  clones well-known Git repositories under the current/given directory.
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Table = import-csv "$PSScriptRoot/../Data/git-repositories.csv"

	[int]$Count = 0
	foreach($Row in $Table) {
		$URL = $Row.URL
		$DirName = $Row.Directory
		if (test-path "$ParentDir/$DirName" -pathType container) {
			"Skipping 📂$DirName because it exists already ..."
			continue
		}
		"⏳ Cloning $URL to 📂$DirName ..."
		& git clone --recurse-submodules "$URL" "$ParentDir/$DirName"
		if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
		$Count++
	}
	"✔️ cloned $Count Git repositories at 📂$ParentDir in $($StopWatch.Elapsed.Seconds) sec."
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
