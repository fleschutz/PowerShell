<#
.SYNOPSIS
	Prints the SHA1 hash of a file
.DESCRIPTION
	This PowerShell script calculates and prints the SHA1 checksum of the given file.
	NOTE: SHA1 is no longer considered secure, use it for simple change validation only!
.PARAMETER path
	Specifies the local file path to the file
.EXAMPLE
	PS> ./get-sha1.ps1 C:\MyFile.txt
	✅ SHA1 hash is 8105D424D350E308AED92BD9DDEB74A1B53C5D7C
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the file path" }
	if (-not(Test-Path $path -pathType leaf)) { throw "Invalid file path given: $path" }

	$result = Get-FileHash -path $path -algorithm SHA1

	"✅ SHA1 hash is $($result.Hash)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
