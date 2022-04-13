<#
.SYNOPSIS
	Starts the File Explorer
.DESCRIPTION
	This PowerShell script launches the File Explorer.
.EXAMPLE
	PS> ./open-file-explorer
.PARAMETER Path
	Specifies the path to the folder to display 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Path = "")

try {
	if ("$Path" -ne "") {
		start-process explorer.exe "$Path"
	} else {
		start-process explorer.exe
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
