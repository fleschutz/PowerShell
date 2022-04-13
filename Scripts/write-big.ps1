<#
.SYNOPSIS
	Writes text in big letters
.DESCRIPTION
	This PowerShell script writes the given text in big letters.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-big "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$text = "")

Set-StrictMode -Version Latest

function BigA { param([int]$Row)
	switch($Row) {
	1 { return "   __   " }
	2 { return "  /__\  " }
	3 { return " /(__)\ " }
	4 { return "(__/\__)" }
	}
}

function BigB { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "| _  )" }
	3 { return "| _ ( " }
	4 { return "|____)" }
	}
}

function BigC { param([int]$Row)
	switch($Row) {
	1 { return "  ___ " }
	2 { return " / __)" }
	3 { return "( (__ " }
	4 { return " \___)" }
	}
}

function BigD { param([int]$Row)
	switch($Row) {
	1 { return " ____  " }
	2 { return "|  _ \ " }
	3 { return "| (_) )" }
	4 { return "|____/ " }
	}
}

function BigE { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "| __) " }
	4 { return "|____)" }
	}
}

function BigF { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "| __) " }
	4 { return "|_)   " }
	}
}

function BigG { param([int]$Row)
	switch($Row) {
	1 { return "  ____ " }
	2 { return " / ___)" }
	3 { return "( (__-." }
	4 { return " \____|" }
	}
}

function BigH { param([int]$Row)
	switch($Row) {
	1 { return " _   _ " }
	2 { return "| |_| |" }
	3 { return "|  _  |" }
	4 { return "|_| |_|" }
	}
}

function BigI { param([int]$Row)
	switch($Row) {
	1 { return " _ " }
	2 { return "| |" }
	3 { return "| |" }
	4 { return "|_|" }
	}
}

function BigJ { param([int]$Row)
	switch($Row) {
	1 { return "   __ " }
	2 { return "  (  |" }
	3 { return ".-_) |" }
	4 { return "\____|" }
	}
}

function BigK { param([int]$Row)
	switch($Row) {
	1 { return " _  _ " }
	2 { return "| |/ )" }
	3 { return "|   ( " }
	4 { return "|_|\_)" }
	}
}

function BigL { param([int]$Row)
	switch($Row) {
	1 { return " _    " }
	2 { return "| |   " }
	3 { return "| |__ " }
	4 { return "|____)" }
	}
}

function BigM { param([int]$Row)
	switch($Row) {
	1 { return " _    _ " }
	2 { return "| \  / |" }
	3 { return "|  \/  |" }
	4 { return "|_|  |_|" }
	}
}

function BigN { param([int]$Row)
	switch($Row) {
	1 { return " _   _ " }
	2 { return "| \ | |" }
	3 { return "|  \| |" }
	4 { return "|_| \_|" }
	}
}

function BigO { param([int]$Row)
	switch($Row) {
	1 { return "  ___  " }
	2 { return " / _ \ " }
	3 { return "( (_) )" }
	4 { return " \___/ " }
	}
}

function BigP { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "|  _ \" }
	3 { return "|  __/" }
	4 { return "|_|   " }
	}
}

function BigQ { param([int]$Row)
	switch($Row) {
	1 { return "  ____  " }
	2 { return " / _  \ " }
	3 { return "( (_) ( " }
	4 { return " \___/\\" }
	}
}

function BigR { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "|  _ \" }
	3 { return "|    /" }
	4 { return "|_|\_)" }
	}
}

function BigS { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "/  __)" }
	3 { return "\__  \" }
	4 { return "(____/" }
	}
}

function BigT { param([int]$Row)
	switch($Row) {
	1 { return " _____ " }
	2 { return "|_   _|" }
	3 { return "  | |  " }
	4 { return "  |_|  " }
	}
}

function BigU { param([int]$Row)
	switch($Row) {
	1 { return " _   _ " }
	2 { return "| | | |" }
	3 { return "| |_| |" }
	4 { return "|_____|" }
	}
}

function BigV { param([int]$Row)
	switch($Row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " \  / " }
	4 { return "  \/  " }
	}
}

function BigW { param([int]$Row)
	switch($Row) {
	1 { return " __    __ " }
	2 { return "\  \/\/  /" }
	3 { return " \      / " }
	4 { return "  \_/\_/  " }
	}
}

function BigX { param([int]$Row)
	switch($Row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " )  ( " }
	4 { return "(_/\_)" }
	}
}

function BigY { param([int]$Row)
	switch($Row) {
	1 { return " _  _ " }
	2 { return "( \/ )" }
	3 { return " \  / " }
	4 { return " (__) " }
	}
}

function BigZ { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "(_   )" }
	3 { return " / /_ " }
	4 { return "(____)" }
	}
}

function Big0 { param([int]$Row)
	switch($Row) {
	1 { return "  ___  " }
	2 { return " / _ \ " }
	3 { return "( (_) )" }
	4 { return " \___/ " }
	}
}

function Big1 { param([int]$Row)
	switch($Row) {
	1 { return " ___ " }
	2 { return "/_  |" }
	3 { return "  | |" }
	4 { return "  |_|" }
	}
}

function Big2 { param([int]$Row)
	switch($Row) {
	1 { return " ___  " }
	2 { return "(__ \ " }
	3 { return " / _/ " }
	4 { return "(____)" }
	}
}

function Big3 { param([int]$Row)
	switch($Row) {
	1 { return " ___ " }
	2 { return "(__ )" }
	3 { return " (_ \" }
	4 { return "(___/" }
	}
}

function Big4 { param([int]$Row)
	switch($Row) {
	1 { return "  __  " }
	2 { return " /. | " }
	3 { return "(_  _)" }
	4 { return "  |_| " }
	}
}

function Big5 { param([int]$Row)
	switch($Row) {
	1 { return " ____ " }
	2 { return "| ___)" }
	3 { return "|__ \ " }
	4 { return "(___/ " }
	}
}

function Big6 { param([int]$Row)
	switch($Row) {
	1 { return "  _  " }
	2 { return " / ) " }
	3 { return "/ _ \" }
	4 { return "\___/" }
	}
}

function Big7 { param([int]$Row)
	switch($Row) {
	1 { return " ___ " }
	2 { return "(__ )" }
	3 { return " / / " }
	4 { return "(_/  " }
	}
} 

function Big8 { param([int]$Row)
	switch($Row) {
	1 { return " ___ " }
	2 { return "( _ )" }
	3 { return "/ _ \" }
	4 { return "\___/" }
	}
} 

function Big9 { param([int]$Row)
	switch($Row) {
	1 { return " ___ " }
	2 { return "/ _ \" }
	3 { return "\_  /" }
	4 { return " (_/ " }
	}
} 

function BigColon { param([int]$Row)
	switch($Row) {
	1 { return "   " }
	2 { return " o " }
	3 { return " o " }
	4 { return "   " }
	}
} 

function BigMinus { param([int]$Row)
	switch($Row) {
	1 { return "      " }
	2 { return " ____ " }
	3 { return "(____)" }
	4 { return "      " }
	}
} 

function BigChar { param([string]$Char, [int]$Row)
	switch($Char) {
	'A' { return BigA $Row }
	'B' { return BigB $Row }
	'C' { return BigC $Row }
	'D' { return BigD $Row }
	'E' { return BigE $Row }
	'F' { return BigF $Row }
	'G' { return BigG $Row }
	'H' { return BigH $Row }
	'I' { return BigI $Row }
	'J' { return BigJ $Row }
	'K' { return BigK $Row }
	'L' { return BigL $Row }
	'M' { return BigM $Row }
	'N' { return BigN $Row }
	'O' { return BigO $Row }
	'P' { return BigP $Row }
	'Q' { return BigQ $Row }
	'R' { return BigR $Row }
	'S' { return BigS $Row }
	'T' { return BigT $Row }
	'U' { return BigU $Row }
	'V' { return BigV $Row }
	'W' { return BigW $Row }
	'X' { return BigX $Row }
	'Y' { return BigY $Row }
	'Z' { return BigZ $Row }
	'0' { return Big0 $Row }
	'1' { return Big1 $Row }
	'2' { return Big2 $Row }
	'3' { return Big3 $Row }
	'4' { return Big4 $Row }
	'5' { return Big5 $Row }
	'6' { return Big6 $Row }
	'7' { return Big7 $Row }
	'8' { return Big8 $Row }
	'9' { return Big9 $Row }
	':' { return BigColon $Row }
	'-' { return BigMinus $Row }
	}
	return "      "
}

try {
	if ($text -eq "" ) { [String]$text = read-host "Enter text to write" }

	[char[]]$ArrayOfChars = $text.ToUpper()
	write-output ""
	for ($Row = 1; $Row -lt 5; $Row++) {
		$Line = ""
		foreach($Char in $ArrayOfChars) {
			$Line += BigChar $Char $Row
		}
		write-output $Line
	}
	write-output ""
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
