#!/snap/bin/powershell

# Syntax:	./MD5.ps1 <file>
# Description:	prints the MD5 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$File)
if ($File -eq "" ) {
	$File = read-host "Enter file: "
}

try {
	$Result = get-filehash $File -algorithm MD5
	write-host "✔️ MD5 hash is" $Result.Hash
	exit 0
} catch { Write-Error $Error[0] }
exit 1
