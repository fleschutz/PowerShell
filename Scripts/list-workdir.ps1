<#
.SYNOPSIS
	Lists the current working directory
.DESCRIPTION
	This PowerShell script lists the current working directory (but not the content itself!)
.EXAMPLE
	PS> ./list-workdir
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$CWD = resolve-path "$PWD"
	"📂$CWD"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
