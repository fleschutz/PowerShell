<#
.SYNOPSIS
	list-workdir.ps1 
.DESCRIPTION
	Lists the current working directory
.EXAMPLE
	PS> .\list-workdir.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$CWD = resolve-path "$PWD"
	"📂$CWD"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
