<#
.SYNOPSIS
	MD5.ps1 [<file>]
.DESCRIPTION
	Prints the MD5 checksum of the given file
.EXAMPLE
	PS> .\MD5.ps1 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$File = "")

try {
	if ($File -eq "" ) { $File = read-host "Enter path to file" }

	$Result = get-filehash $File -algorithm MD5
	"MD5 hash is" $Result.Hash
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
