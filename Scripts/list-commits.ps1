<#
.SYNOPSIS
	Lists all commits in a Git repository
.DESCRIPTION
	This PowerShell script lists all commits in a Git repository. Supported output formats are: list, compact, normal or JSON.
.PARAMETER RepoDir
	Specifies the path to the Git repository.
.PARAMETER Format
	Specifies the output format: list|compact|normal|JSON
.EXAMPLE
	PS> ./list-commits

	ID      Date                            Committer               Description
	--      ----                            ---------               -----------
	ccd0d3e Wed Sep 29 08:28:20 2021 +0200  Markus Fleschutz        Fix typo
	291d785 Wed Sep 29 08:18:28 2021 +0200  Markus Fleschutz        Update README.md
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$RepoDir = "$PWD", [string]$Format = "list")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	write-progress "🢃 Fetching latest tags..."
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
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
