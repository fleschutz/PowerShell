#!/snap/bin/powershell

# Syntax:       ./close-file-explorer.ps1 
# Description:	closes Microsoft File Explorer gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

."$PathToRepo/Scripts/close-program.ps1" "explorer" 
