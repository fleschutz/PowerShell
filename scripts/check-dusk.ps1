<#
.SYNOPSIS
	Checks the time of dusk 
.DESCRIPTION
	This PowerShell script queries the time of dusk and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-dusk.ps1
	Dusk is in 2 hours at 8 PM.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
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
	$String = (Invoke-WebRequest http://wttr.in/?format="%d" -UserAgent "curl" -useBasicParsing).Content
	$Hour,$Minute,$Second = $String -split ':'
	$Dusk = Get-Date -Hour $Hour -Minute $Minute -Second $Second
	$Now = [DateTime]::Now
	if ($Now -lt $Dusk) {
                $TimeSpan = TimeSpanToString($Dusk - $Now)
                $Reply = "Dusk is in $TimeSpan at $($Dusk.ToShortTimeString())."
        } else {
                $TimeSpan = TimeSpanToString($Now - $Dusk)
                $Reply = "Dusk was $TimeSpan ago at $($Dusk.ToShortTimeString())."
        }
	Write-Output $Reply
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
