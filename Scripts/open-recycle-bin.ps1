<#
.SYNOPSIS
	open-recycle-bin.ps1 
.DESCRIPTION
	Starts the File Explorer with the recycle bin folder
.EXAMPLE
	PS> .\open-recycle-bin.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	start shell:recyclebinfolder
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
