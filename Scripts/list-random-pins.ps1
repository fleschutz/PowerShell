#!/snap/bin/powershell

# Syntax:	./list-random-pins.ps1
# Description:	prints a list of random PIN's
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$PIN_Length = 5
$Columns = 12
$Lines = 24

function GeneratePIN() {
	$Generator = New-Object System.Random
	for ($i = 0; $i -lt $PIN_Length; $i++) {
		$PIN += [char]$Generator.next(48,57)
	}
	return $PIN
}

try {
	write-output ""
	for ($j = 0; $j -lt $Lines; $j++) {
		$Line = ""
		for ($k = 0; $k -lt $Columns; $k++) {
			$Line += GeneratePIN
			$Line += "   "
		}
		write-output $Line
	}
	write-output ""
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
