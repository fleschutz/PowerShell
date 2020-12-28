#!/snap/bin/powershell

# Syntax:       ./close-windows-terminal.ps1 
# Description:	closes Windows Terminal gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$ExitCode = close-program.ps1 "WindowsTerminal"
exit $ExitCode
