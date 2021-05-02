<#
.SYNTAX       zip-dir.ps1 [<directory>]
.DESCRIPTION  creates a zip archive of the given directory
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Directory = "")
if ($Directory -eq "" ) { $Directory = read-host "Enter the path to the directory to zip" }

try {
	$Directory = resolve-path $Directory
	compress-archive -path $Directory -destinationPath $Directory.zip

	"✔️ zip archive created: $($Directory).zip"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
