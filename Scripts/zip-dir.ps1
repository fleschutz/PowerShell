<#
.SYNOPSIS
	zip-dir.ps1 [<directory>]
.DESCRIPTION
	Creates a zip archive of the given directory
.EXAMPLE
	PS> .\zip-dir.ps1 C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$Directory = "")

try {
	if ($Directory -eq "" ) { $Directory = read-host "Enter the path to the directory to zip" }

	$Directory = resolve-path $Directory
	compress-archive -path $Directory -destinationPath $Directory.zip

	"✔️ created zip archive: $($Directory).zip"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
