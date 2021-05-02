<#
.SYNTAX       create-tag.ps1 [<new-tag-name>] [<repo-dir>]
.DESCRIPTION  creates a new tag in the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($NewTagName = "", $RepoDir = "$PWD")
if ($NewTagName -eq "") { $NewTagName = read-host "Enter new tag name" }

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Repository is NOT clean: $Result" }

	& "$PSScriptRoot/fetch-repo.ps1"
	if ($lastExitCode -ne "0") { throw "Script 'fetch-repo.ps1' failed" }

	& git tag "$NewTagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git tag $NewTagName' failed!" }

	& git push origin "$NewTagName"
	if ($lastExitCode -ne "0") { throw "Error: 'git push origin $NewTagName' failed!" }

	"🔖 tag $NewTagName has been created"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
