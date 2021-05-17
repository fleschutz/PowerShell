<#
.SYNTAX       make-repos.ps1 [<parent-dir>]
.DESCRIPTION  builds all Git repositories under the current/given directory
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$ParentDirName = (get-item "$ParentDir").Name
	"Building $($Folders.Count) Git repositories at 📂$ParentDirName..."

	foreach ($Folder in $Folders) {
		& "$PSScriptRoot/make-repo.ps1" "$Folder"
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ built $($Folders.Count) Git repositories at 📂$ParentDirName in $Elapsed sec."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
