<#
.SYNOPSIS
	SHA256.ps1 [<file>]
.DESCRIPTION
	Prints the SHA256 checksum of the given file
.EXAMPLE
	PS> .\SHA256.ps1 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$File = "")

try {
	if ($File -eq "" ) { $File = read-host "Enter the filename" }

	$Result = get-filehash $File -algorithm SHA256

	"✔️ SHA256 hash is:" $Result.Hash
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
