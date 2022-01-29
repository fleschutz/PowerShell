<#
.SYNOPSIS
	Lists the details of all Git repositories in a folder
.DESCRIPTION
	This PowerShell script lists the details of all Git repositories in the given folder.
.PARAMETER ParentDir
	Specifies the path to the parent folder.
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	Repository  Branch Status
	------      ------ ------
	cmake       main   clean
	opencv      master clean
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$ParentDir = "$PWD")

function ListRepos { param([string]$ParentDir)
	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	foreach ($Folder in $Folders) {
		$Repository = (get-item "$Folder").Name
		$Branch = (git -C "$Folder" branch --show-current)
		$Status = (git -C "$Folder" status --short)
		if ("$Status" -eq "") { $Status = "clean" }

		New-Object PSObject -property @{ 'Repository'="$Repository"; 'Branch'="$Branch"; 'Status'="$Status"; }
	}
}

try {
	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | format-table -property Repository,Branch,Status
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
