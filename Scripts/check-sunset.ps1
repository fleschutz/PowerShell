<#
.SYNOPSIS
	Checks the time of sunset
.DESCRIPTION
	This script queries the time of sunset and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-sunset
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function TimeSpanToString { param([TimeSpan]$Delta)
        $Result = ""
        if ($Delta.Hours -eq 1) {       $Result += "1 hour and "
        } elseif ($Delta.Hours -gt 1) { $Result += "$($Delta.Hours) hours and "
        }
        if ($Delta.Minutes -eq 1) { $Result += "1 minute"
        } else {                    $Result += "$($Delta.Minutes) minutes"
        }
        return $Result
}

try {
	[system.threading.thread]::currentThread.currentCulture=[system.globalization.cultureInfo]"en-US"
	$String = (Invoke-WebRequest http://wttr.in/?format="%s" -UserAgent "curl" -useBasicParsing).Content
	$Hour,$Minute,$Second = $String -split ':'
	$Sunset = Get-Date -Hour $Hour -Minute $Minute -Second $Second
	$Now = [DateTime]::Now
	if ($Now -lt $Sunset) {
                $TimeSpan = TimeSpanToString($Sunset - $Now)
                $Reply = "Sunset is in $TimeSpan at $($Sunset.ToShortTimeString())."
        } else {
                $TimeSpan = TimeSpanToString($Now - $Sunset)
                $Reply = "Sunset was $TimeSpan ago at $($Sunset.ToShortTimeString())."
        }
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
