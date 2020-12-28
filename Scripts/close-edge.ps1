#!/snap/bin/powershell

# Syntax:       ./close-edge.ps1 
# Description:	closes Microsoft Edge gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

."$PathToRepo/Scripts/close-program.ps1" "msedge"
