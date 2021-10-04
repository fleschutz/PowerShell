<#
.SYNOPSIS
	Starts the File Explorer with the recycle bin folder
.DESCRIPTION
	open-recycle-bin.ps1 
.EXAMPLE
	PS> ./open-recycle-bin
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start shell:recyclebinfolder
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
