<#
.SYNOPSIS
	Checks for Tea time
.DESCRIPTION
	This script checks the time until Tea time and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-tea-time
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
	$Now = [DateTime]::Now
	$TeaTime = Get-Date -Hour 16 -Minute 0 -Second 0
	if ($Now -lt $TeaTime) {
		$TimeSpan = TimeSpanToString($TeaTime - $Now)
		$Reply = "Tea time is in $TimeSpan."
	} else {
		$TimeSpan = TimeSpanToString($Now - $TeaTime)
		$Reply = "Tea time was $TimeSpan ago."
	}
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
