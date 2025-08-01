The *speak-italian.ps1* Script
===========================

This PowerShell script speaks the given text with an Italian text-to-speech (TTS) voice.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/speak-italian.ps1 [[-text] <String>] [<CommonParameters>]

-text <String>
    Specifies the Italian text to speak
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./speak-italian.ps1 Ciao

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Speaks text in Italian 
.DESCRIPTION
	This PowerShell script speaks the given text with an Italian text-to-speech (TTS) voice.
.PARAMETER text
	Specifies the Italian text to speak
.EXAMPLE
	PS> ./speak-italian.ps1 Ciao
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter the Italian text to speak" }

	$TTS = New-Object -ComObject SAPI.SPVoice
	foreach ($voice in $TTS.GetVoices()) {
		if ($voice.GetDescription() -like "*- Italian*") {
			$TTS.Voice = $voice
			[void]$TTS.Speak($text)
			exit 0 # success
		}
	}
	throw "No Italian text-to-speech voice found - please install one."
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:41)*
