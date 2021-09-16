<#
.SYNOPSIS
	get-md5.ps1 [<file>]
.DESCRIPTION
	Prints the MD5 checksum of the given file
.EXAMPLE
	PS> .\MD5.ps1 C:\MyFile.txt
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$file = "")

try {
	if ($file -eq "" ) { $file = read-host "Enter path to file" }

	$Result = get-filehash $file -algorithm MD5

	"✔️ MD5 hash is" $Result.Hash
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
