<#
.SYNOPSIS
	Prints the SHA512 hash of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA512 checksum of the given file.
.PARAMETER path
	Specifies the local file path to the file
.EXAMPLE
	PS> ./get-sha512.ps1 C:\MyFile.txt
	✅ SHA512 hash is CEB4AD71524996EB8AA3ADCE04F1E45636A4B58B8BF4462E6971CF2E56B4293E
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the file path" }
	if (-not(Test-Path $path -pathType leaf)) { throw "Invalid file path given: $path" }

	$result = Get-FileHash -path $path -algorithm SHA512

	"✅ SHA512 hash is $($result.Hash)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
