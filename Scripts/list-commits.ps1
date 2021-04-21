<#
.SYNTAX       list-commits.ps1 [<repo-dir>] [<format>]
.DESCRIPTION  lists all commits in the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Format = "compact")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& "$PSScriptRoot/fetch-repo.ps1"
	if ($lastExitCode -ne "0") { throw "Script 'fetch-repo.ps1' failed" }

	write-output ""
	write-output "List of Git Commits"
	write-output "-------------------"
	if ($Format -eq "compact") {
		& git log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an %cr%Creset' --abbrev-commit
		if ($lastExitCode -ne "0") { throw "'git log' failed" }
	} else {
		& git log
		if ($lastExitCode -ne "0") { throw "'git log' failed" }
	}
	write-output ""
	write-output ""
	exit 0
} catch {
	write-error "⚠️ ERROR: $($Error[0]) (line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
