<#
.SYNTAX       build-repos.ps1 [<parent-dir>]
.DESCRIPTION  builds all Git repositories under the current/given directory
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }
	set-location $ParentDir

	[int]$Count = 0
	get-childItem $ParentDir -attributes Directory | foreach-object {
		& "$PSScriptRoot/build-repo.ps1" "$($_.FullName)"
		$Count++
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	write-host -foregroundColor green "✔️ built $Count Git repositories at $ParentDir in $Elapsed sec."
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
