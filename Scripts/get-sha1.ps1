<#
.SYNOPSIS
	Prints the SHA1 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA1 checksum of the given file.
.PARAMETER file
	Specifies the path to the file
.EXAMPLE
	PS> ./get-sha1 C:\MyFile.txt
	✔️ SHA1 hash is 8105D424D350E308AED92BD9DDEB74A1B53C5D7C
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = Read-Host "Enter the filename" }

	$Result = get-filehash $file -algorithm SHA1

	"✔️ SHA1 hash is $($Result.Hash)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
