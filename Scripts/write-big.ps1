#!/snap/bin/powershell

# Syntax:       ./write-big.ps1 [<text>]
# Description:	writes the given text in big letters
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)

function BigA() { param([Int]$Row)
	switch($Row) {
	1 { return "   __    " }
	2 { return "  /__\   " }
	3 { return " /(__)\  " }
	4 { return "(__)(__) " }
	}
}

function BigB() { param([Int]$Row)
	switch($Row) {
	1 { return " ____  " }
	2 { return "| _  ) " }
	3 { return "| _ (  " }
	4 { return "|____) " }
	}
}

function BigC() { param([Int]$Row)
	switch($Row) {
	1 { return "  ___  " }
	2 { return " / __) " }
	3 { return "( (__  " }
	4 { return " \___) " }
	}
}

function BigD() { param([Int]$Row)
	switch($Row) {
	1 { return " ____   " }
	2 { return "|  _ \  " }
	3 { return "| (_) ) " }
	4 { return "|____/  " }
	}
}

function BigE() { param([Int]$Row)
	switch($Row) {
	1 { return " ____  " }
	2 { return "| ___) " }
	3 { return "| __)  " }
	4 { return "|____) " }
	}
}

function BigF() { param([Int]$Row)
	switch($Row) {
	1 { return " ____  " }
	2 { return "| ___) " }
	3 { return "| __)  " }
	4 { return "|_)    " }
	}
}

function BigG() { param([Int]$Row)
	switch($Row) {
	1 { return "  ____  " }
	2 { return " / ___) " }
	3 { return "( (__-. " }
	4 { return " \____| " }
	}
}

function BigH() { param([Int]$Row)
	switch($Row) {
	1 { return " _   _  " }
	2 { return "| |_| | " }
	3 { return "|  _  | " }
	4 { return "|_| |_| " }
	}
}

function BigChar() {
	param([String]$Char, [Int]$Row)
	switch($Char) {
	'A' { return BigA $Row }
	'B' { return BigB $Row }
	'C' { return BigC $Row }
	'D' { return BigD $Row }
	'E' { return BigE $Row }
	'F' { return BigF $Row }
	'G' { return BigG $Row }
	'H' { return BigH $Row }
	'I' { return BigA $Row }
	'J' { return BigA $Row }
	'K' { return BigA $Row }
	'L' { return BigA $Row }
	'M' { return BigA $Row }
	'N' { return BigA $Row }
	'O' { return BigA $Row }
	'P' { return BigA $Row }
	'Q' { return BigA $Row }
	'R' { return BigA $Row }
	'S' { return BigA $Row }
	'T' { return BigA $Row }
	'U' { return BigA $Row }
	'V' { return BigA $Row }
	'W' { return BigA $Row }
	'X' { return BigA $Row }
	'Y' { return BigA $Row }
	'Z' { return BigA $Row }
	'0' { return BigA $Row }
	'1' { return BigA $Row }
	'2' { return BigA $Row }
	'3' { return BigA $Row }
	'4' { return BigA $Row }
	'5' { return BigA $Row }
	'6' { return BigA $Row }
	'7' { return BigA $Row }
	'8' { return BigA $Row }
	'9' { return BigA $Row }
	}
	return "        "
}

try {
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	[char[]]$CharArray = $Text.ToUpper()
	write-output ""
	for ($Row = 1; $Row -lt 5; $Row++) {
		$Line = ""
		foreach($Char in $CharArray) {
			$Line += BigChar $Char $Row
		}
		write-output $Line
	}
	write-host ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
