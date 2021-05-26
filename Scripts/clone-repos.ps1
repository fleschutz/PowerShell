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
		$Directory = $Row.Directory
		$Branch = $Row.Branch
		$URL = $Row.URL
		if (test-path "$ParentDir/$Directory" -pathType container) {
			"📂$Directory exists already, skipping..."
			continue
		}
		"🢃 Cloning 📂$Directory from $URL, $Branch branch..."
		& git clone --branch "$Branch" --recurse-submodules "$URL" "$ParentDir/$Directory"
		if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
		$Count++
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cloned $Count Git repositories at 📂$ParentDir in $Elapsed sec."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
