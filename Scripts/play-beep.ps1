#!/snap/bin/powershell

# Syntax:       ./play-beep.ps1
# Description:	plays a beep sound
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	[console]::beep(500,300)
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
