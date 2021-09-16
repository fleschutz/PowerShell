<#
.SYNOPSIS
	list-commits.ps1 [<RepoDir>] [<Format>]
.DESCRIPTION
	Lists all commits in a Git repository (format is: list|compact|normal|JSON).
.EXAMPLE
	PS> .\list-commits.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD", [string]$Format = "list")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"🢃 Fetching latest tags..."
	& git -C "$RepoDir" fetch --all --quiet
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	if ($Format -eq "list") {
		""
		"ID      Date                            Committer               Description"
		"--      ----                            ---------               -----------"
		& git log --pretty=format:"%h%x09%ad%x09%an%x09%s"
	} elseif ($Format -eq "compact") {
		""
		"List of Git Commits"
		"-------------------"
		& git -C "$RepoDir" log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an %cr%Creset' --abbrev-commit
		if ($lastExitCode -ne "0") { throw "'git log' failed" }
	} elseif ($Format -eq "JSON") {
		& git -C "$RepoDir" log --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},'
	} else {
		""
		"List of Git Commits"
		"-------------------"
		& git -C "$RepoDir" log
		if ($lastExitCode -ne "0") { throw "'git log' failed" }
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
