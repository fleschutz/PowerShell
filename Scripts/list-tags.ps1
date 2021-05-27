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

	$RepoDirName = (get-item "$RepoDir").Name
	"🢃 Fetching updates for Git repository 📂$RepoDirName ..."

	& git -C "$RepoDir" fetch --all 
	if ($lastExitCode -ne "0") { throw "'git fetch --all' failed" }

	write-output ""
	write-output "Git Tags"
	write-output "--------"

	& git -C "$RepoDir" tag --list "$Pattern" --column
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
