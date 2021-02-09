#!/bin/powershell
<#
.SYNTAX         ./zip-dir.ps1 [<directory>]
.DESCRIPTION	creates a zip archive of the given directory
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Directory = "")

try {
	if ($Directory -eq "" ) {
		$Directory = read-host "Enter path to directory to zip"
	}

	compress-archive -path $Directory -destinationPath $Directory.zip
	write-output "OK - created zip archive $($Directory).zip"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
