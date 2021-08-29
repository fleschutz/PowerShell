<#
.SYNOPSIS
	clear-recycle-bin.ps1 
.DESCRIPTION
	Removes the content of the recycle bin folder (can not be undo).
.EXAMPLE
	PS> .\clear-recycle-bin.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Clear-RecycleBin -Confirm:$false
	"✔️ recycle bin have been emptied"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
