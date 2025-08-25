<#
.SYNOPSIS
	Lists the latests tags in all Git repositories in a folder
.DESCRIPTION
	This PowerShell script lists the latest tags in all Git repositories in the specified folder.
.PARAMETER ParentDir
	Specifies the path to the parent folder
.EXAMPLE
	PS> ./list-latest-tags C:\MyRepos
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

try {
	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	$FolderCount = $Folders.Count
	$ParentDirName = (get-item "$ParentDir").Name
	"Found $FolderCount subfolders in 📂$ParentDirName..."

	foreach ($Folder in $Folders) {
		$FolderName = (get-item "$Folder").Name

#		& git -C "$Folder" fetch --tags
#		if ($lastExitCode -ne 0) { throw "'git fetch --tags' failed" }

		$LatestTagCommitID = (git -C "$Folder" rev-list --tags --max-count=1)
		$LatestTag = (git -C "$Folder" describe --tags $LatestTagCommitID)
		"* $FolderName $LatestTag ($LatestTagCommitID)"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
