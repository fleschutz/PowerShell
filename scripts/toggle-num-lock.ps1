<#
.SYNOPSIS
	Toggle Num Lock
.DESCRIPTION
	This PowerShell script toggles the Num Lock key state.
.EXAMPLE
	PS> ./toggle-num-lock
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$wsh = New-Object -ComObject WScript.Shell
	$wsh.SendKeys('{NUMLOCK}')
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
