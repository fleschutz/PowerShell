<#
.SYNOPSIS
	Prints the SHA256 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA256 checksum of the given file.
.PARAMETER file
	Specifies the path to the file
.EXAMPLE
	PS> ./get-sha256 C:\MyFile.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = read-host "Enter the filename" }

	$Result = get-filehash $file -algorithm SHA256

	"✔️ SHA256 hash is:" $Result.Hash
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
