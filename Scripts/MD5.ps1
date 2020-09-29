#!/snap/bin/powershell
#
# Syntax:	./MD5.ps1 <file>
# Description:	prints the MD5 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$File)
$Result = get-filehash $File -algorithm MD5
write-host $Result.Hash
exit 0
