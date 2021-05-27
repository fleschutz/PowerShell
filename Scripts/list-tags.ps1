<#
.SYNTAX       list-tags.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION  lists all tags in the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Pattern="*")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"🢃 Fetching updates..."
	& git -C "$RepoDir" fetch --all --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch --all' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	[system.threading.thread]::currentthread.currentculture=[system.globalization.cultureinfo]"en-US"
	""
	"🔖 Tags in Git repository 📂$RepoDirName as of $((Get-Date).ToShortDateString()):"

	& git -C "$RepoDir" tag --list "$Pattern" --column
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
