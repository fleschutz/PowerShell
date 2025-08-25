<#
.SYNOPSIS
	Writes text in Braille
.DESCRIPTION
	This PowerShell script writes text in Braille.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-braille "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

function BrailleA { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleB { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleC { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleD { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleE { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleF { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleG { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleH { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleI { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleJ { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleK { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleL { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleM { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleN { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleO { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleP { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleQ { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleR { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleS { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleT { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleU { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleV { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".." }
	}
}

function BrailleW { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "o." }
	}
}

function BrailleX { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleY { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".." }
	}
}

function BrailleZ { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".." }
	}
}

function Braille1 { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille2 { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille3 { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille4 { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille5 { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille6 { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille7 { param([int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille8 { param([int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille9 { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
} 

function Braille0 { param([int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleChar { param([string]$Char, [int]$Row)
	switch($Char) {
	'A' { return BrailleA $Row }
	'B' { return BrailleB $Row }
	'C' { return BrailleC $Row }
	'D' { return BrailleD $Row }
	'E' { return BrailleE $Row }
	'F' { return BrailleF $Row }
	'G' { return BrailleG $Row }
	'H' { return BrailleH $Row }
	'I' { return BrailleI $Row }
	'J' { return BrailleJ $Row }
	'K' { return BrailleK $Row }
	'L' { return BrailleL $Row }
	'M' { return BrailleM $Row }
	'N' { return BrailleN $Row }
	'O' { return BrailleO $Row }
	'P' { return BrailleP $Row }
	'Q' { return BrailleQ $Row }
	'R' { return BrailleR $Row }
	'S' { return BrailleS $Row }
	'T' { return BrailleT $Row }
	'U' { return BrailleU $Row }
	'V' { return BrailleV $Row }
	'W' { return BrailleW $Row }
	'X' { return BrailleX $Row }
	'Y' { return BrailleY $Row }
	'Z' { return BrailleZ $Row }
	'1' { return Braille1 $Row }
	'2' { return Braille2 $Row }
	'3' { return Braille3 $Row }
	'4' { return Braille4 $Row }
	'5' { return Braille5 $Row }
	'6' { return Braille6 $Row }
	'7' { return Braille7 $Row }
	'8' { return Braille8 $Row }
	'9' { return Braille9 $Row }
	'0' { return Braille0 $Row }
	}
	return "    "
}

try {
	if ($text -eq "" ) { $text = read-host "Enter text to write" }

	[char[]]$ArrayOfChars = $text.ToUpper()
	write-output ""
	for ($Row = 1; $Row -lt 4; $Row++) {
		$Line = ""
		foreach($Char in $ArrayOfChars) {
			$Line += BrailleChar $Char $Row
			$Line += "  "
		}
		write-output $Line
	}
	write-output ""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
