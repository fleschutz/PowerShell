<#
.SYNOPSIS
	Writes text in Braille
.DESCRIPTION
	This PowerShell script writes text in Braille.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-braille.ps1 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

function BrailleA { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleB { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleC { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function BrailleD { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleE { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function BrailleF { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleG { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleH { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleI { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function BrailleJ { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleK { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleL { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleM { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".o" }
	}
}

function BrailleN { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleO { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".o" }
	}
}

function BrailleP { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleQ { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleR { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleS { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return ".o" }
	}
}

function BrailleT { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".." }
	3 { return ".o" }
	}
}

function BrailleU { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleV { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return ".." }
	}
}

function BrailleW { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "o." }
	}
}

function BrailleX { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return ".." }
	}
}

function BrailleY { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "o." }
	3 { return ".." }
	}
}

function BrailleZ { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return ".." }
	}
}

function Braille1 { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille2 { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille3 { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "oo" }
	3 { return "oo" }
	}
}

function Braille4 { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille5 { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return "o." }
	3 { return "oo" }
	}
}

function Braille6 { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".o" }
	3 { return "oo" }
	}
}

function Braille7 { param([int]$row)
	switch($row) {
	1 { return ".." }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille8 { param([int]$row)
	switch($row) {
	1 { return ".o" }
	2 { return ".." }
	3 { return "oo" }
	}
} 

function Braille9 { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".o" }
	3 { return "oo" }
	}
} 

function Braille0 { param([int]$row)
	switch($row) {
	1 { return "o." }
	2 { return ".." }
	3 { return "oo" }
	}
}

function BrailleChar { param([string]$char, [int]$row)
	switch($char) {
	'A' { return BrailleA $row }
	'B' { return BrailleB $row }
	'C' { return BrailleC $row }
	'D' { return BrailleD $row }
	'E' { return BrailleE $row }
	'F' { return BrailleF $row }
	'G' { return BrailleG $row }
	'H' { return BrailleH $row }
	'I' { return BrailleI $row }
	'J' { return BrailleJ $row }
	'K' { return BrailleK $row }
	'L' { return BrailleL $row }
	'M' { return BrailleM $row }
	'N' { return BrailleN $row }
	'O' { return BrailleO $row }
	'P' { return BrailleP $row }
	'Q' { return BrailleQ $row }
	'R' { return BrailleR $row }
	'S' { return BrailleS $row }
	'T' { return BrailleT $row }
	'U' { return BrailleU $row }
	'V' { return BrailleV $row }
	'W' { return BrailleW $row }
	'X' { return BrailleX $row }
	'Y' { return BrailleY $row }
	'Z' { return BrailleZ $row }
	'0' { return Braille0 $row }
	'1' { return Braille1 $row }
	'2' { return Braille2 $row }
	'3' { return Braille3 $row }
	'4' { return Braille4 $row }
	'5' { return Braille5 $row }
	'6' { return Braille6 $row }
	'7' { return Braille7 $row }
	'8' { return Braille8 $row }
	'9' { return Braille9 $row }
	}
	return "    "
}

try {
	if ($text -eq "" ) { $text = Read-Host "Enter the text to write in Braille" }

	[char[]]$arrayOfChars = $text.ToUpper()
	Write-Output ""
	for ([int]$row = 1; $row -lt 4; $row++) {
		$line = ""
		foreach($char in $arrayOfChars) {
			$line += BrailleChar $char $row
			$line += "  "
		}
		Write-Output $line
	}
	Write-Output ""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (at script line $($_.InvocationInfo.ScriptlineNumber))"
	exit 1
}
