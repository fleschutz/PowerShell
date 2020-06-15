#!/snap/bin/powershell
#
# Description:	prints the SHA256 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
# 
param(
[string]$File)

$Result = get-filehash $File
write-host $Result.Hash
exit 0
