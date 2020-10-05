#!/snap/bin/powershell
#
# Syntax:       ./zipdir.ps1 <path-to-folder>
# Description:	creates a zip archive from the given folder
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Path)


try {
	Compress-Archive -Path $Path -DestinationPath $Path.zip
	exit 0
} catch { Write-Error $Error[0] }
exit 1
