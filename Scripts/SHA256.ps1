#!/snap/bin/powershell

# Syntax:	./SHA256.ps1 [<file>]
# Description:	prints the SHA256 checksum of the given file
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$File)
try {
	if ($File -eq "" ) {
		$File = read-host "Enter file"
	}

	$Result = get-filehash $File -algorithm SHA256
	write-output "SHA256 hash is:" $Result.Hash
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
