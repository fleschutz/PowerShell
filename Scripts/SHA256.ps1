#!/snap/bin/powershell
#
# PowerShell Script to Calculate SHA256 Hashes for Files
# ------------------------------------------------------
# Author:  Markus Fleschutz
# Source:  github.com/fleschutz/PowerShell
# License: CC0
param(
[string]$File)

$Result = get-filehash $File
write-host $Result.Hash
exit 0
