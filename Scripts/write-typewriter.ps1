#!/snap/bin/powershell

# Syntax:       ./write-typewriter.ps1 [<text>]
# Description:	writes the given test with the typewriter effect
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Text)
if ($Text -eq "" ) {
	$Text = "`nHello World`n-----------`nPowerShell is cross-platform`nPowerShell is open-source`nPowerShell is easy to learn`nPowerShell is fully documented`n`nThanks for watching`n`n:-)`n`n"
}
$Speed = 250 # milliseconds

try {
	$Random = New-Object System.Random

	$Text -split '' | ForEach-Object {
		Write-Host -nonewline $_
		Start-Sleep -milliseconds $(1 + $Random.Next($Speed))
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
