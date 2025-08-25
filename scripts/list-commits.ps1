<#
.SYNOPSIS
	Lists Git commits
.DESCRIPTION
	This PowerShell script lists all commits in a Git repository. Supported output formats are: pretty, list, compact, normal or JSON.
.PARAMETER RepoDir
	Specifies the file path to the local Git repository.
.PARAMETER Format
	Specifies the output format: pretty|list|compact|normal|JSON (pretty by default)
.EXAMPLE
	PS> ./list-commits

	ID      Date                            Committer               Description
	--      ----                            ---------               -----------
	ccd0d3e Wed Sep 29 08:28:20 2021 +0200  Markus Fleschutz        Fix typo
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD", [string]$format = "pretty")

try {
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access directory: $pathToRepo" }

	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Progress "Fetching latest updates..."
	& git -C "$pathToRepo" fetch --all --quiet
	if ($lastExitCode -ne 0) { throw "'git fetch' failed" }
	Write-Progress -Completed "Done."

	if ($format -eq "pretty") {
		""
		& git -C "$pathToRepo" log --graph --format=format:'%C(bold yellow)%s%C(reset)%d by %an 🕘%cs 🔗%h' --all
	} elseif ($format -eq "list") {
		""
		"Hash            Date            Author                  Description"
		"----            ----            ------                  -----------"
		& git log --pretty=format:"%h%x09%cs%x09%an%x09%s"
	} elseif ($format -eq "compact") {
		""
		"List of Git Commits"
		"-------------------"
		& git -C "$pathToRepo" log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an %cr%Creset' --abbrev-commit
		if ($lastExitCode -ne 0) { throw "'git log' failed" }
	} elseif ($format -eq "JSON") {
		& git -C "$pathToRepo" log --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},'
	} else {
		""
		"List of Git Commits"
		"-------------------"
		& git -C "$pathToRepo" log
		if ($lastExitCode -ne 0) { throw "'git log' failed" }
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
