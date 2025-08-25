Script: *write-big.ps1*
========================

This PowerShell script writes the given text in big letters.

Parameters
----------
```powershell
PS> ./write-big.ps1 [[-text] <String>] [<CommonParameters>]

-text <String>
    Specifies the text to write ("Hello World" by default)
    
    Required?                    false
    Position?                    1
    Default value                Hello World
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
PS> ./write-big.ps1
 _   _  ____  _     _      ___         __    __   ___   ____  _     ____
| |_| || ___)| |   | |    / _ \       \  \/\/  / / _ \ |  _ \| |   |  _ \
|  _  || __) | |__ | |__ ( (_) )       \      / ( (_) )|    /| |__ | (_) )
|_| |_||____)|____)|____) \___/         \_/\_/   \___/ |_|\_)|____)|____/

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
	Writes text in big letters
.DESCRIPTION
	This PowerShell script writes the given text in big letters.
.PARAMETER text
	Specifies the text to write ("Hello World" by default)
.EXAMPLE
	PS> ./write-big.ps1
	 _   _  ____  _     _      ___         __    __   ___   ____  _     ____
	| |_| || ___)| |   | |    / _ \       \  \/\/  / / _ \ |  _ \| |   |  _ \
	|  _  || __) | |__ | |__ ( (_) )       \      / ( (_) )|    /| |__ | (_) )
	|_| |_||____)|____)|____) \___/         \_/\_/   \___/ |_|\_)|____)|____/
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "Hello World")

Set-StrictMode -Version Latest

function BigA { param([int]$row)
	switch($row) {
	1 { return "   __   " }
	2 { return "  /__\  " }
	3 { return " /(__)\ " }
	4 { return "(__/\__)" }
	}
}

function BigB { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "| _  )" }
	3 { return "| _ ( " }
	4 { return "|____)" }
	}
}

function BigC { param([int]$row)
	switch($row) {
	1 { return "  ___ " }
	2 { return " / __)" }
	3 { return "( (__ " }
	4 { return " \___)" }
	}
}

function BigD { param([int]$row)
	switch($row) {
	1 { return " ____  " }
	2 { return "|  _ \ " }
	3 { return "| (_) )" }
	4 { return "|____/ " }
	}
}

function BigE { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "| __) " }
	4 { return "|____)" }
	}
}

function BigF { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "| __) " }
	4 { return "|_)   " }
	}
}

function BigG { param([int]$row)
	switch($row) {
	1 { return "  ____ " }
	2 { return " / ___)" }
	3 { return "( (__-." }
	4 { return " \____|" }
	}
}

function BigH { param([int]$row)
	switch($row) {
	1 { return " _   _ " }
	2 { return "| |_| |" }
	3 { return "|  _  |" }
	4 { return "|_| |_|" }
	}
}

function BigI { param([int]$row)
	switch($row) {
	1 { return " _ " }
	2 { return "| |" }
	3 { return "| |" }
	4 { return "|_|" }
	}
}

function BigJ { param([int]$row)
	switch($row) {
	1 { return "   __ " }
	2 { return "  (  |" }
	3 { return ".-_) |" }
	4 { return "\____|" }
	}
}

function BigK { param([int]$row)
	switch($row) {
	1 { return " _  _ " }
	2 { return "| |/ )" }
	3 { return "|   ( " }
	4 { return "|_|\_)" }
	}
}

function BigL { param([int]$row)
	switch($row) {
	1 { return " _    " }
	2 { return "| |   " }
	3 { return "| |__ " }
	4 { return "|____)" }
	}
}

function BigM { param([int]$row)
	switch($row) {
	1 { return " _    _ " }
	2 { return "| \  / |" }
	3 { return "|  \/  |" }
	4 { return "|_|  |_|" }
	}
}

function BigN { param([int]$row)
	switch($row) {
	1 { return " _   _ " }
	2 { return "| \ | |" }
	3 { return "|  \| |" }
	4 { return "|_| \_|" }
	}
}

function BigO { param([int]$row)
	switch($row) {
	1 { return "  ___  " }
	2 { return " / _ \ " }
	3 { return "( (_) )" }
	4 { return " \___/ " }
	}
}

function BigP { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "|  _ \" }
	3 { return "|  __/" }
	4 { return "|_|   " }
	}
}

function BigQ { param([int]$row)
	switch($row) {
	1 { return "  ____  " }
	2 { return " / _  \ " }
	3 { return "( (_) ( " }
	4 { return " \___/\\" }
	}
}

function BigR { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "|  _ \" }
	3 { return "|    /" }
	4 { return "|_|\_)" }
	}
}

function BigS { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "/  __)" }
	3 { return "\__  \" }
	4 { return "(____/" }
	}
}

function BigT { param([int]$row)
	switch($row) {
	1 { return " _____ " }
	2 { return "|_   _|" }
	3 { return "  | |  " }
	4 { return "  |_|  " }
	}
}

function BigU { param([int]$row)
	switch($row) {
	1 { return " _   _ " }
	2 { return "| | | |" }
	3 { return "| |_| |" }
	4 { return "|_____|" }
	}
}

function BigV { param([int]$row)
	switch($row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " \  / " }
	4 { return "  \/  " }
	}
}

function BigW { param([int]$row)
	switch($row) {
	1 { return " __    __ " }
	2 { return "\  \/\/  /" }
	3 { return " \      / " }
	4 { return "  \_/\_/  " }
	}
}

function BigX { param([int]$row)
	switch($row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " )  ( " }
	4 { return "(_/\_)" }
	}
}

function BigY { param([int]$row)
	switch($row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " \  / " }
	4 { return " (__) " }
	}
}

function BigZ { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "(_   )" }
	3 { return " / /_ " }
	4 { return "(____)" }
	}
}

function Big0 { param([int]$row)
	switch($row) {
	1 { return "  ___  " }
	2 { return " / _ \ " }
	3 { return "( (_) )" }
	4 { return " \___/ " }
	}
}

function Big1 { param([int]$row)
	switch($row) {
	1 { return " ___ " }
	2 { return "/_  |" }
	3 { return "  | |" }
	4 { return "  |_|" }
	}
}

function Big2 { param([int]$row)
	switch($row) {
	1 { return " ___  " }
	2 { return "(__ \ " }
	3 { return " / _/ " }
	4 { return "(____)" }
	}
}

function Big3 { param([int]$row)
	switch($row) {
	1 { return " ___ " }
	2 { return "(__ )" }
	3 { return " (_ \" }
	4 { return "(___/" }
	}
}

function Big4 { param([int]$row)
	switch($row) {
	1 { return "  __  " }
	2 { return " /. | " }
	3 { return "(_  _)" }
	4 { return "  |_| " }
	}
}

function Big5 { param([int]$row)
	switch($row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "|__ \ " }
	4 { return "(___/ " }
	}
}

function Big6 { param([int]$row)
	switch($row) {
	1 { return "  _  " }
	2 { return " / ) " }
	3 { return "/ _ \" }
	4 { return "\___/" }
	}
}

function Big7 { param([int]$row)
	switch($row) {
	1 { return " ___ " }
	2 { return "(__ )" }
	3 { return " / / " }
	4 { return "(_/  " }
	}
} 

function Big8 { param([int]$row)
	switch($row) {
	1 { return " ___ " }
	2 { return "( _ )" }
	3 { return "/ _ \" }
	4 { return "\___/" }
	}
} 

function Big9 { param([int]$row)
	switch($row) {
	1 { return " ___ " }
	2 { return "/ _ \" }
	3 { return "\_  /" }
	4 { return " (_/ " }
	}
} 

function BigColon { param([int]$row)
	switch($row) {
	1 { return "   " }
	2 { return " o " }
	3 { return " o " }
	4 { return "   " }
	}
} 

function BigMinus { param([int]$row)
	switch($row) {
	1 { return "      " }
	2 { return " ____ " }
	3 { return "(____)" }
	4 { return "      " }
	}
} 

function BigChar { param([string]$char, [int]$row)
	switch($char) {
	'A' { return BigA $row }
	'B' { return BigB $row }
	'C' { return BigC $row }
	'D' { return BigD $row }
	'E' { return BigE $row }
	'F' { return BigF $row }
	'G' { return BigG $row }
	'H' { return BigH $row }
	'I' { return BigI $row }
	'J' { return BigJ $row }
	'K' { return BigK $row }
	'L' { return BigL $row }
	'M' { return BigM $row }
	'N' { return BigN $row }
	'O' { return BigO $row }
	'P' { return BigP $row }
	'Q' { return BigQ $row }
	'R' { return BigR $row }
	'S' { return BigS $row }
	'T' { return BigT $row }
	'U' { return BigU $row }
	'V' { return BigV $row }
	'W' { return BigW $row }
	'X' { return BigX $row }
	'Y' { return BigY $row }
	'Z' { return BigZ $row }
	'0' { return Big0 $row }
	'1' { return Big1 $row }
	'2' { return Big2 $row }
	'3' { return Big3 $row }
	'4' { return Big4 $row }
	'5' { return Big5 $row }
	'6' { return Big6 $row }
	'7' { return Big7 $row }
	'8' { return Big8 $row }
	'9' { return Big9 $row }
	':' { return BigColon $row }
	'-' { return BigMinus $row }
	}
	return "      "
}

try {
	Write-Output ""
	[char[]]$arrayOfChars = $text.ToUpper()
	for ($row = 1; $row -lt 5; $row++) {
		$line = ""
		foreach($char in $arrayOfChars) {
			$line += BigChar $char $row
		}
		Write-Output $line
	}
	Write-Output ""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 08/25/2025 16:51:29)*
