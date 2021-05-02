<#
.SYNTAX       download-dir.ps1 [<URL>]
.DESCRIPTION  downloads a directory tree from the given URL
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($URL = "")
if ($URL -eq "") { $URL = read-host "Enter directory URL to download" }

try {
	& wget --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget' - make sure wget is installed and available" }

	& wget --mirror --convert-links --adjust-extension --page-requisites --no-parent $URL --directory-prefix . --no-verbose
	if ($lastExitCode -ne "0") { throw "Can't execute 'wget --mirror $URL'" }

	write-host -foregroundColor green "OK - directory downloaded from $URL"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
