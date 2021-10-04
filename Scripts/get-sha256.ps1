<#
.SYNOPSIS
	Prints the SHA256 checksum of a file
.DESCRIPTION
	get-sha256.ps1 [<file>]
.EXAMPLE
	PS> ./get-sha256 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = read-host "Enter the filename" }

	$Result = get-filehash $file -algorithm SHA256

	"✔️ SHA256 hash is:" $Result.Hash
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
