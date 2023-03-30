<#
.SYNOPSIS
	Switches browser tabs
.DESCRIPTION
	This PowerShell script switches browser tabs automatically every <n> seconds (by pressing Ctrl + PageDown).
.PARAMETER Interval
        Specifies the switch interval in seconds (10 sec per default)
.EXAMPLE
	PS> ./switch-tabs
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/talk2windows
#>

param([int]$Interval = 10) # in seconds

try {
	Write-Host "⏳ Switching browser tabs automatically every $Interval seconds..."
	Write-Host "   (click into the browser window to activate it, press Ctrl + C here to stop it)"
	$obj = New-Object -com wscript.shell
	while ($true) {
		$obj.SendKeys("^{PGDN}")
		Start-Sleep -seconds $Interval
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
