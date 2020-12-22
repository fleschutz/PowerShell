#!/snap/bin/powershell

# Syntax:       ./csv-to-text.ps1 [<csv-file>]
# Description:	converts the given CSV file into a text list
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Path)

try {
	if ($Path -eq "" ) {
		$Path = read-host "Enter path to CSV file"
	}

	$Table = Import-CSV -path "$Path" -header A,B,C,D,E,F,G,H

	foreach($Row in $Table) {
		write-output "* $($Row.A) $($Row.B) $($Row.C) $($Row.D) $($Row.E) $($Row.F) $($Row.G) $($Row.H)"
#		write-output "* [$($Row.B)](ipfs::$($Row.A))"
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
