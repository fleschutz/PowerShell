<#
.SYNOPSIS
	Prints the MD5 checksum of a file
.DESCRIPTION
	This PowerShell script calculates and prints the MD5 checksum of the given file.
	NOTE: MD5 is no longer considered secure, use it for simple change validation only!
.PARAMETER path
	Specifies the file path to the file
.EXAMPLE
	PS> ./get-md5.ps1 C:\MyFile.txt
	✅ MD5 hash is 041E16F16E60AD250EB794AF0681BD4A
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "" ) { $path = Read-Host "Enter the file path" }
	if (-not(Test-Path $path -pathType leaf)) { throw "Invalid file path given: $path" }

	$result = Get-FileHash -path $path -algorithm MD5

	"✅ MD5 hash is $($result.Hash)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
