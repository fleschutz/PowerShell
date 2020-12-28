#!/snap/bin/powershell

# Syntax:       ./close-edge.ps1 
# Description:	closes Microsoft Edge gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$ExitCode = close-program.ps1 "msedge" 
exit $ExitCode
