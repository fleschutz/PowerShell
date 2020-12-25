#!/snap/bin/powershell

# Syntax:	./MD5.ps1 [<file>]
# Description:	prints the MD5 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
param([string]$File)
try {
	if ($File -eq "" ) {
		$File = read-host "Enter path to file"
	}
	$Result = get-filehash $File -algorithm MD5
	write-output "MD5 hash is" $Result.Hash
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
