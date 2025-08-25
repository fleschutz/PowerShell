<#
.SYNOPSIS
	Writes animated text
.DESCRIPTION
	This PowerShell script writes text centered and animated to the console.
.PARAMETER text
	Specifies the text line to write ("Welcome to PowerShell" by default)
.PARAMETER speed
	Specifies the animation speed per character (10ms by default)
.EXAMPLE
	PS> ./write-animated.ps1
	(watch and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "Welcome to PowerShell", [int]$speed = 10) # 10ms

function WriteLine([string]$line) {
	[int]$end = $line.Length
	$startPos = $HOST.UI.RawUI.CursorPosition
	$spaces = "                                                                     "
	[int]$termHalfWidth = 120 / 2
	foreach($pos in 1 .. $end) {
		$HOST.UI.RawUI.CursorPosition = $startPos
		Write-Host "$($spaces.Substring(0, $termHalfWidth - $pos / 2) + $line.Substring(0, $pos))" -noNewline
		Start-Sleep -milliseconds $speed
	}
	Write-Host ""
}

try {
	WriteLine $text 
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
