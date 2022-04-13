<#
.SYNOPSIS
	Lists the content of the recycle bin folder
.DESCRIPTION
	This PowerShell script lists the content of the recycle bin folder.
.EXAMPLE
	PS> ./list-recycle-bin
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	(New-Object -ComObject Shell.Application).NameSpace(0x0a).Items() | Select-Object Name,Size,Path
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
