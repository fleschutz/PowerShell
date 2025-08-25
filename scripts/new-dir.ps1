<#
.SYNOPSIS
	Creates a new directory
.DESCRIPTION
	This PowerShell script creates an empty new directory in the filesystem.
.PARAMETER path
	Specifies the path and filename of the new directory
.EXAMPLE
	PS> ./new-dir.ps1 MyCollection
	✅ New 📂C:\Temp\MyCollection created.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "")

try {
	if ($path -eq "") { $path = Read-Host "Enter the filename (and path) of the new directory" }

	if (Test-Path $path) { throw "Directory at $path already exists" }

	$null =	(New-Item -itemType directory -path $path)

	$path = Resolve-Path $path
	"✅ New 📂$path created."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
