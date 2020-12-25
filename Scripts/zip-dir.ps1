#!/snap/bin/powershell

# Syntax:       ./zip-dir.ps1 [<path-to-folder>]
# Description:	creates a zip archive of the given folder
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Path)
try {
	if ($Path -eq "" ) {
		$URL = read-host "Enter path to folder to zip"
	}

	Compress-Archive -Path $Path -DestinationPath $Path.zip
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
