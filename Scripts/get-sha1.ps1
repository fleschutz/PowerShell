<#
.SYNOPSIS
	Prints the SHA1 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA1 checksum of the given file.
.PARAMETER file
	Specifies the path to the file
.EXAMPLE
	PS> ./get-sha1 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = read-host "Enter the filename" }

	$Result = get-filehash $file -algorithm SHA1

	"✔️ SHA1 hash is" $Result.Hash
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
