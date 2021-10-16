<#
.SYNOPSIS
	Lists the current working directory
.DESCRIPTION
	This script lists the current working directory (but not the content itself!)
.EXAMPLE
	PS> ./list-workdir
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$CWD = resolve-path "$PWD"
	"📂$CWD"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
