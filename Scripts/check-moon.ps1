<#
.SYNOPSIS
	Checks the moon
.DESCRIPTION
	This script determines moon details and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-moon
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Day = (Invoke-WebRequest http://wttr.in/?format="%M" -UserAgent "curl" -useBasicParsing).Content
	if ($Day -eq "0") {	  $Reply = "Today is "
	} elseif ($Day -eq "1") { $Reply = "Yesterday was "
	} else {                  $Reply = "$Day days ago "
	}

	$Phase = (Invoke-WebRequest http://wttr.in/?format="%m" -UserAgent "curl" -useBasicParsing).Content	
	if ($Phase -eq "🌑") {       $Reply += "new moon"
	} elseif ($Phase -eq "🌒") { $Reply += "waxing crescent moon"
	} elseif ($Phase -eq "🌓") { $Reply += "first quarter moon"
	} elseif ($Phase -eq "🌔") { $Reply += "waxing gibbous moon"
	} elseif ($Phase -eq "🌕") { $Reply += "full moon"
	} elseif ($Phase -eq "🌖") { $Reply += "waning gibbous moon"
	} elseif ($Phase -eq "🌗") { $Reply += "last quarter moon"
	} elseif ($Phase -eq "🌘") { $Reply += "waning crescent moon"
	}
	$Reply += "."
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
