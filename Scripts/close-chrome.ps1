#!/snap/bin/powershell

# Syntax:       ./close-chrome.ps1 
# Description:	closes Google Chrome gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent

Start-Process -WorkingDirectory "$PathToRepo/Scripts" -FilePath "./close-program.ps1" -ArgumentList "chrome" -NoNewWindow -Wait
