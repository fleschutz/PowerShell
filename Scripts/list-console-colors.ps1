<#
.SYNOPSIS
	list-console-colors.ps1 
.DESCRIPTION
	Lists all console colors
.EXAMPLE
	PS> ./list-console-colors
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Colors = [Enum]::GetValues([ConsoleColor])
	""
	"Name     `tForeground     `tBackground"
	"----     `t----------     `t----------"
	foreach($Color in $Colors) {
		write-host -noNewline "$Color     `t"
		write-host -noNewline -foregroundcolor $Color "$Color     `t"
		write-host -noNewline -backgroundcolor $Color "$Color"
		write-host ""
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
