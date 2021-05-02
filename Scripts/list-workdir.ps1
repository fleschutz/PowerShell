<#
.SYNTAX       list-workdir.ps1 
.DESCRIPTION  lists the current working directory
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	$CWD = resolve-path "$PWD"
	"📂$CWD"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
