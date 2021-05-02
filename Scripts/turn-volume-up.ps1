<#
.SYNTAX       turn-volume-up.ps1 [<percent>]
.DESCRIPTION  turns the audio volume up (+10% by default)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param([int]$Percent = 10)

try {
	$obj = New-Object -com wscript.shell
	for ([int]$i = 0; $i -lt $Percent; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	"🔊️ volume +$($Percent)%"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
