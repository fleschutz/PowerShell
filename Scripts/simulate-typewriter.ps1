#!/snap/bin/powershell

# Syntax:       ./simulate-typewriter.ps1 [<message>]
# Description:	prints the given message with the typewriter effect
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$message)
if ($message -eq "" ) {
	$message = "`nHello World`n-----------`nPowerShell is cross-platform`nPowerShell is open-source`nPowerShell is easy to learn`nPowerShell is fully documented`n`nThanks for watching`n`n:-)`n`n"
}

$Speed = 250
$Random = New-Object System.Random

$message -split '' |
  ForEach-Object {
    Write-Host -nonewline $_
    Start-Sleep -milliseconds $(1 + $Random.Next($Speed))
   }

exit 0
