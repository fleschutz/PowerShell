#!/bin/powershell
<#
.SYNTAX         ./zip-dir.ps1 [<directory>]
.DESCRIPTION	creates a zip archive of the given directory
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Directory = "")

try {
	if ($Directory -eq "" ) {
		$Directory = read-host "Enter path to directory to zip"
	}

	compress-archive -path $Directory -destinationPath $Directory.zip

	write-host -foregroundColor green "Done - created zip archive $($Directory).zip"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
