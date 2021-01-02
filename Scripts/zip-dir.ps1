#!/snap/bin/powershell
<#
.SYNTAX         ./zip-dir.ps1 [<path-to-folder>]
.DESCRIPTION	creates a zip archive of the given folder
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Path = "")

try {
	if ($Path -eq "" ) {
		$URL = read-host "Enter path to folder"
	}

	compress-archive -path $Path -destinationPath $Path.zip
	write-output "OK - folder has been compressed to $($Path).zip"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
