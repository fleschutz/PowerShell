#!/snap/bin/powershell

# Syntax:       ./close-chrome.ps1 
# Description:	closes Google Chrome gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$ExitCode = close-program.ps1 "chrome" 
exit $ExitCode
