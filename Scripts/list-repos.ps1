<#
.SYNOPSIS
	Lists Git repos
.DESCRIPTION
	This PowerShell script lists details of all Git repositories in a folder.
.PARAMETER ParentDir
	Specifies the path to the parent directory.
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	Repository   Latest Tag   Branch    Updates  Status
	----------   ----------   ------    -------  ------
	📂cmake      v3.23.0      🌵main    ↓0       ✔️clean
	📂opencv     4.5.5        🌵main    ↓0       ⚠️modified
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

function ListRepos { 
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	foreach($Folder in $Folders) {
		$Repository = (Get-Item "$Folder").Name
		$LatestTagCommitID = (git -C "$Folder" rev-list --tags --max-count=1)
		if ($LatestTagCommitID -ne "") {
	        	$LatestTag = (git -C "$Folder" describe --tags $LatestTagCommitID)
		} else {
			$LatestTag = ""
		}
		$Branch = (git -C "$Folder" branch --show-current)
		$NumCommits = (git -C "$Folder" rev-list HEAD...origin/$Branch --count)
		$Status = (git -C "$Folder" status --short)
		if ("$Status" -eq "") { $Status = "✔️clean" }
		elseif ("$Status" -like " M *") { $Status = "⚠️modified" }
		New-Object PSObject -property @{'Repository'="📂$Repository";'Latest Tag'="$LatestTag";'Branch'="🌵$Branch";'Updates'="↓$NumCommits";'Status'="$Status";}
	}
}

try {
	if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='Repository';width=20},@{e='Latest Tag';width=18},@{e='Branch';width=14},@{e='Updates';width=8},Status
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
