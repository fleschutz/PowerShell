<#
.SYNOPSIS
	SHA1.ps1 [<file>]
.DESCRIPTION
	Prints the SHA1 checksum of the given file
.EXAMPLE
	PS> .\SHA1.ps1 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param($File = "")
if ($File -eq "" ) { $File = read-host "Enter the filename" }

try {
	$Result = get-filehash $File -algorithm SHA1
	write-output "SHA1 hash is" $Result.Hash
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
