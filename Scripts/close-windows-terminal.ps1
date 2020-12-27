#!/snap/bin/powershell

# Syntax:       ./close-windows-terminal.ps1 
# Description:	closes the Windows Terminal program gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

close-program.ps1 "WindowsTerminal"
#try {
#	exit 0
#} catch {
#	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
#	exit 1
#}
