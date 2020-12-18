#!/snap/bin/powershell

# Syntax:       ./write-big.ps1 [<text>]
# Description:	writes the given text in big letters
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)

function big_A() {
	param([Int]$Line)
	switch($Line) {
	0 { return "     A      " }
	1 { return "    A A     " }
	2 { return "   A   A    " }
	3 { return "  AAAAAAA   " }
	4 { return " AAAAAAAAA  " }
	5 { return "AA       AA " }
	}
}

function big_B() {
	param([Int]$Line)
	switch($Line) {
	0 { return "BBBBBBB  " }
	1 { return "B      B " }
	2 { return "BBBBBBB  " }
	3 { return "BBBBBBB  " }
	4 { return "B      B " }
	5 { return "BBBBBBB  " }
	}
}

function big_char() {
	param([String]$Char, [Int]$Line)
	switch($Char) {
	'A' { return big_A $Line }
	'B' { return big_B $Line }
	'C' { return big_A $Line }
	'D' { return big_A $Line }
	'E' { return big_A $Line }
	'F' { return big_A $Line }
	'G' { return big_A $Line }
	'H' { return big_A $Line }
	'I' { return big_A $Line }
	'J' { return big_A $Line }
	'K' { return big_A $Line }
	'L' { return big_A $Line }
	'M' { return big_A $Line }
	'N' { return big_A $Line }
	'O' { return big_A $Line }
	'P' { return big_A $Line }
	'Q' { return big_A $Line }
	'R' { return big_A $Line }
	'S' { return big_A $Line }
	'T' { return big_A $Line }
	'U' { return big_A $Line }
	'V' { return big_A $Line }
	'W' { return big_A $Line }
	'X' { return big_A $Line }
	'Y' { return big_A $Line }
	'Z' { return big_A $Line }
	'0' { return big_A $Line }
	'1' { return big_A $Line }
	'2' { return big_A $Line }
	'3' { return big_A $Line }
	'4' { return big_A $Line }
	'5' { return big_A $Line }
	'6' { return big_A $Line }
	'7' { return big_A $Line }
	'8' { return big_A $Line }
	'9' { return big_A $Line }
	}
	return "        "
}

try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	write-host ""
	[char[]]$TextArray = $Text.ToUpper()
	for ($Line = 0; $Line -lt 6; $Line++) {
		foreach($Char in $TextArray) {
			$Out = big_char $Char $Line
			write-host -nonewline $Out
		}
		write-host ""
	}
	write-host ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
