<#
.SYNTAX       clear-recycle-bin.ps1 
.DESCRIPTION  removes the content of the recycle bin folder (can not be undo!)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	Clear-RecycleBin -Confirm:$false
	"✔️ recycle bin have been emptied"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
