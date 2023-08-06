<#
.SYNOPSIS
	Prints the SHA256 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA256 checksum of the given file.
.PARAMETER file
	Specifies the path to the file
.EXAMPLE
	PS> ./get-sha256 C:\MyFile.txt
	✔️ SHA256 hash is: CEB4AD71524996EB8AA3ADCE04F1E45636A4B58B8BF4462E6971CF2E56B4293E
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = Read-Host "Enter the filename" }

	$Result = get-filehash $file -algorithm SHA256

	"✔️ SHA256 hash is: $($Result.Hash)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
