#!/snap/bin/powershell
#
# Syntax:	./SHA1.ps1 <file>
# Description:	prints the SHA1 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$File)

try {
	$Result = get-filehash $File -algorithm SHA1
	write-host $Result.Hash
	exit 0
} catch { Write-Error $Error[0] }
exit 1
