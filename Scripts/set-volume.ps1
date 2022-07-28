<#
.SYNOPSIS
	Sets the volume 
.DESCRIPTION
	This PowerShell script sets the audio volume in percent.
.PARAMETER volume
	Specifies the percent number
.EXAMPLE
	PS> ./set-volume 50
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Param([Parameter(Mandatory=$true)] [ValidateRange(0,100)] [Int] $Volume)

try {
	# Create the Windows Shell object. 
	$obj = New-Object -ComObject WScript.Shell
    
	# First, set volume to zero. 
	1..50 | ForEach-Object {  $obj.SendKeys( [char] 174 )  }
    
	# Calculate number of (volume up) key presses 
	$keyPresses = [Math]::Ceiling( $Volume / 2 )
    
	# Raise volume to specified level. 
	for( $i = 0; $i -lt $keyPresses; $i++ ) {
		$obj.SendKeys( [char] 175 )
	}
	& "$PSScriptRoot/give-reply.ps1" "$($Volume)% volume."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
