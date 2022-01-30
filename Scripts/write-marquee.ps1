<#
.SYNOPSIS
	Writes text as marquee
.DESCRIPTION
	This PowerShell script writes text as marquee.
.PARAMETER text
	Specifies the text to write
.PARAMETER speed
	Specifies the marquee speed (60 ms per default)
.EXAMPLE
	PS> ./write-marquee "Hello World"
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$text = "PowerShell is powerful! PowerShell is cross-platform! PowerShell is open-source! PowerShell is easy to learn! Powershell is fully documented", [int]$speed = 60) # 60 ms pause

function StartMarquee { param([string]$text)
	$Length = $text.Length
	$Start = 1
	$End = ($Length - 80)

	clear-host
	write-output ""
	write-output "------------------------------------------------------------------------------------"
	$StartPosition = $HOST.UI.RawUI.CursorPosition
	$StartPosition.X = 2
	write-output "|                                                                                  |"
	write-output "------------------------------------------------------------------------------------"

	foreach ($Pos in $Start .. $End) {
		$HOST.UI.RawUI.CursorPosition = $StartPosition
		$TextToDisplay = $text.Substring($Pos, 80)
		write-host -nonewline $TextToDisplay
		start-sleep -milliseconds $speed
	}
	write-output ""
	write-output ""
	write-output ""
}

StartMarquee "                                                                                    +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++ $text +++                                                                                         "
exit 0 # success
