<#
.SYNOPSIS
	Prevents the standby
.DESCRIPTION
	This PowerShell script prevents the standby mode by pressing <NUMLOCK> from time to time.
.EXAMPLE
	PS> ./prevent-standby.ps1
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$myshell = New-Object -com "Wscript.Shell"

	while ($true) {
		$myshell.SendKeys('{NUMLOCK}')
		Start-Sleep -milliseconds 50
		$myshell.SendKeys('{NUMLOCK}')
		Start-Sleep -seconds 60
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
