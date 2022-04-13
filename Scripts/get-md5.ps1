<#
.SYNOPSIS
	Prints the MD5 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the MD5 checksum of the given file.
.PARAMETER file
	Specifies the path to the file
.EXAMPLE
	PS> ./get-md5 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = read-host "Enter path to file" }

	$Result = get-filehash $file -algorithm MD5

	"✔️ MD5 hash is" $Result.Hash
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
