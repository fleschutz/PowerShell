<#
.SYNTAX       clean-repos.ps1 [<parent-dir>]
.DESCRIPTION  cleans all Git repositories under the current/given directory from untracked files (including submodules)
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
	get-childItem "$ParentDir" -attributes Directory | foreach-object {
		"Cleaning Git repository 📂$($_.Name) from untracked files ..."
		set-location $_.FullName

		& git clean -fdx # force + recurse into dirs + don't use the standard ignore rules
		if ($lastExitCode -ne "0") { throw "'git clean -fdx' failed" }

		& git submodule foreach --recursive git clean -fdx 
		if ($lastExitCode -ne "0") { throw "'git clean -fdx' in submodules failed" }

		set-location ..
		$Count++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	write-host -foregroundColor green "✔️ cleaned $Count Git repositories at $ParentDir in $Elapsed sec."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
