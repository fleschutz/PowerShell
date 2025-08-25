<#
.SYNOPSIS
	Sets the audio volume 
.DESCRIPTION
	This PowerShell script sets the audio volume to the given value in percent (0..100).
.PARAMETER percent
	Specifies the volume in percent (0..100)
.EXAMPLE
	PS> ./set-volume.ps1 50
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Param([Parameter(Mandatory=$true)] [ValidateRange(0,100)] [Int] $percent)

try {
	# Create the Windows Shell object. 
	$obj = New-Object -ComObject WScript.Shell
    
	# First, set volume to zero. 
	for ([int]$i = 0; $i -lt 100; $i += 2) {
		$obj.SendKeys([char]174) # each tick is -2%
	}
    
	# Raise volume to specified level. 
	for ([int]$i = 0; $i -lt $percent; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
