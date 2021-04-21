<#
.SYNTAX       write-marquee.ps1 [<text>] [<speed>]
.DESCRIPTION  writes the given text as marquee
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "PowerShell is powerful! PowerShell is cross-platform! PowerShell is open-source! PowerShell is easy to learn! Powershell is fully documented", [int]$Speed = 60) # 60 ms pause

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
		start-sleep -milliseconds $Speed
	}
	write-output ""
	write-output ""
	write-output ""
}

StartMarquee "                                                                                    +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++ $Text +++                                                                                         "
exit 0
