#!/snap/bin/powershell

# Syntax:       ./turn-volume-up.ps1 [<percent>]
# Description:	turns the volume up (+10% by default)
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

Param([Int]$Percent = 10)

try {
	$obj = New-Object -com wscript.shell
	for ($i = 0; $i -lt $Percent; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	write-output "OK"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
