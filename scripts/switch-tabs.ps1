<#
.SYNOPSIS
	Switches Web browser tabs
.DESCRIPTION
	This PowerShell script switches automatically from tab to tab every <n> seconds (by pressing Ctrl + PageDown).
.PARAMETER timeInterval
        Specifies the time interval in seconds (10sec per default)
.EXAMPLE
	PS> ./switch-tabs.ps1
	⏳ Switching from tab to tab automatically every 10 seconds...
	💡 Hint: click the Web browser to activate it. Press <Ctrl> <C> here to stop it.
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]$timeInterval = 10) # in seconds

try {
	Write-Host "⏳ Switching from tab to tab automatically every $timeInterval seconds..."
	Write-Host "💡 Hint: click the Web browser to activate it. Press <Ctrl> <C> here to stop it."
	$obj = New-Object -com wscript.shell
	while ($true) {
		$obj.SendKeys("^{PGDN}")
		Start-Sleep -seconds $timeInterval
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
