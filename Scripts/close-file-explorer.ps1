#!/snap/bin/powershell

# Syntax:       ./close-file-explorer.ps1 
# Description:	closes Microsoft File Explorer gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$ExitCode = close-program.ps1 "explorer" 
exit $ExitCode
