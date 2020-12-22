#!/snap/bin/powershell

# Syntax:       ./write-braille.ps1 [<text>]
# Description:	writes the given text in Braille
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)

function BrailleA() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleB() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleC() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleD() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleE() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleF() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleG() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleH() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleI() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleJ() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleK() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleL() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleM() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleN() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleO() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleP() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleQ() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleR() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleS() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleT() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleU() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleV() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".." }
	}
}

function BrailleW() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "o." }
	}
}

function BrailleX() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleY() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".." }
	}
}

function BrailleZ() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".." }
	}
}

function Braille1() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille2() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille3() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille4() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille5() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille6() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille7() { param([Int]$Row)
	switch($Row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille8() { param([Int]$Row)
	switch($Row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille9() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
} 

function Braille0() { param([Int]$Row)
	switch($Row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleChar() { param([String]$Char, [Int]$Row)
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
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	[char[]]$ArrayOfChars = $Text.ToUpper()
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
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
