Script: *write-morse-code.ps1*
========================

This PowerShell script writes the given text in Morse code.

Parameters
----------
```powershell
PS> ./write-morse-code.ps1 [[-text] <String>] [[-speed] <Int32>] [<CommonParameters>]

-text <String>
    Specifies the text to write
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-speed <Int32>
    Specifies the speed of one time unit (100 ms per default)
    
    Required?                    false
    Position?                    2
    Default value                100
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
PS> ./write-morse-code ABC
● ―   ― ● ● ●   ― ● ― ●

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
	Writes Morse code
.DESCRIPTION
	This PowerShell script writes the given text in Morse code.
.PARAMETER text
	Specifies the text to write
.PARAMETER speed
	Specifies the speed of one time unit (100 ms per default)
.EXAMPLE
	PS> ./write-morse-code ABC
	● ―   ― ● ● ●   ― ● ― ●
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "", [int]$speed = 100) # one time unit in milliseconds

function gap { param([int]$Length)
	for ([int]$i = 0; $i -lt $Length; $i++) {
		Write-Host " " -noNewline
	}
	Start-Sleep -milliseconds ($Length * $speed)
}

function dot {
	Write-Host "●" -noNewline
	Start-Sleep -milliseconds $speed # signal
}

function dash {
	Write-Host "―" -noNewline
	Start-Sleep -milliseconds (3 * $speed) # signal
}

function Char2MorseCode { param([string]$Char)
	switch($Char) {
	'A' { dot; gap 1; dash; gap 3 }
	'B' { dash; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'C' { dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 3 }
	'D' { dash; gap 1; dot; gap 1; dot; gap 3 }
	'E' { dot; gap 3 }
	'F' { dot; gap 1; dot; gap 1; dash; gap 1; dot; gap 3 }
	'G' { dash; gap 1; dash; gap 1; dot; gap 3 }
	'H' { dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'I' { dot; gap 1; dot; gap 3 }
	'J' { dot; gap 1; dash; gap 1; dash; gap 1; dash; gap 3 }
	'K' { dash; gap 1; dot; gap 1; dash; gap 3 }
	'L' { dot; gap 1; dash; gap 1; dot; gap 1; dot; gap 3 }
	'M' { dash; gap 1; dash; gap 3 }
	'N' { dash; gap 1; dot; gap 3 }
	'O' { dash; gap 1; dash; gap 1; dash; gap 3 }
	'P' { dot; gap 1; dash; gap 1; dash; gap 1; dot; gap 3 }
	'Q' { dash; gap 1; dash; gap 1; dot; gap 1; dash; gap 3 }
	'R' { dot; gap 1; dash; gap 1; dot; gap 3 }
	'S' { dot; gap 1; dot; gap 1; dot; gap 3 }
	'T' { dash; gap 3 }
	'U' { dot; gap 1; dot; gap 1; dash; gap 3 }
	'V' { dot; gap 1; dot; gap 1; dot; gap 1; dash; gap 3 }
	'W' { dot; gap 1; dash; gap 1; dash; gap 3 }
	'X' { dash; gap 1; dot; gap 1; dot; gap 1; dash; gap 3 }
	'Y' { dash; gap 1; dot; gap 1; dash; gap 1; dash; gap 3 }
	'Z' { dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 3 }
	'1' { dot; gap 1; dash; gap 1; dash; gap 1; dash; gap 1; dash; gap 3 }
	'2' { dot; gap 1; dot; gap 1; dash; gap 1; dash; gap 1; dash; gap 3 }
	'3' { dot; gap 1; dot; gap 1; dot; gap 1; dash; gap 1; dash; gap 3 }
	'4' { dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 1; dash; gap 3 }
	'5' { dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'6' { dash; gap 1; dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'7' { dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'8' { dash; gap 1; dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 3 }
	'9' { dash; gap 1; dash; gap 1; dash; gap 1; dash; gap 1; dot; gap 3 }
	'0' { dash; gap 1; dash; gap 1; dash; gap 1; dash; gap 1; dash; gap 3 }
	'?' { dot; gap 1; dot; gap 1; dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 3 }
	'!' { dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 1; dash; gap 1; dash; gap 3 }
	'.' { dot; gap 1; dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 1; dash; gap 3 }
	',' { dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 1; dash; gap 1; dash; gap 3 }
	"'" { dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 3 }
	':' { dash; gap 1; dash; gap 1; dash; gap 1; dot; gap 1; dot; gap 1; dot; gap 3 }
	'+' { dot; gap 1; dash; gap 1; dot; gap 1; dash; gap 1; dot; gap 3 }
	'-' { dash; gap 1; dot; gap 1; dot; gap 1; dot; gap 1; dot; gap 1; dash; gap 3 }
	'*' { dash; gap 1; dot; gap 1; dot; gap 1; dash; gap 3 }
	'÷' { dash; gap 1; dot; gap 1; dot; gap 1; dash; gap 1; dot; gap 3 }
	default { gap 7 } # medium gap (between words)
	}
}

try {
	if ($text -eq "" ) { [string]$text = Read-Host "Enter text to write" }

	[char[]]$ArrayOfChars = $text.ToUpper()
	foreach($Char in $ArrayOfChars) {
		Char2MorseCode $Char 
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/07/2025 16:01:08)*
