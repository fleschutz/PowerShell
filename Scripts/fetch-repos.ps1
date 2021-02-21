#!/bin/powershell
<#
.SYNTAX         ./fetch-repos.ps1 [<directory>]
.DESCRIPTION	fetches all Git repositories under the current/given directory (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Directory = "")

if ($Directory -eq "") {
	$Directory = "$PWD"
}

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	$Files = get-childItem -path $Directory
	foreach ($File in $Files) {
		if ($File.Mode -like "d*") {
			$Filename = $File.Name
			write-progress "Fetching $Filename ..."
			set-location $Filename
			& git fetch --recurse-submodules
			set-location ..
		} 
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
