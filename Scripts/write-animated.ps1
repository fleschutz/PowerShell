#!/bin/powershell
<#
.SYNTAX         ./write-animated.ps1 [<line1>] .. [line9>] [<speed>]
.DESCRIPTION	writes animated text
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Line1 = "", [string]$Line2 = "", [string]$Line3 = "", [string]$Line4 = "", [string]$Line5 = "", [string]$Line6 = "", [string]$Line7 = "", [string]$Line8 = "", [string]$Line9 = "", [int]$Speed = 50) # 50 ms pause

function WriteAnimatedLine { param([string]$Line, [int]$Speed)
	[int]$Start = 1
	[int]$End = $Line.Length
	$StartPosition = $HOST.UI.RawUI.CursorPosition
	$Spaces = "                                                                     "

	if ($Line -ne "") {
		foreach ($Pos in $Start .. $End) {
			$TextToDisplay = $Spaces.Substring(0, 40 - $pos / 2) + $Line.Substring(0, $Pos)
			write-host -nonewline $TextToDisplay
			start-sleep -milliseconds $Speed
			$HOST.UI.RawUI.CursorPosition = $StartPosition
		}
		write-host ""
	}
}

if ($Line1 -eq "") {
	$Line1 = "Welcome to PowerShell Scripts"
	$Line2 = ""
	$Line3 = "This repository contains useful and cross-platform PowerShell scripts."
	$Line4 = "Send your e-mail feedback to: markus@fleschutz.de"
	$Line5 = "Best regards,"
	$Line6 = "Markus"
}
write-host ""
WriteAnimatedLine $Line1 $Speed
WriteAnimatedLine $Line2 $Speed
WriteAnimatedLine $Line3 $Speed
WriteAnimatedLine $Line4 $Speed
WriteAnimatedLine $Line5 $Speed
WriteAnimatedLine $Line6 $Speed
WriteAnimatedLine $Line7 $Speed
WriteAnimatedLine $Line8 $Speed
WriteAnimatedLine $Line9 $Speed
write-host ""
exit 0
