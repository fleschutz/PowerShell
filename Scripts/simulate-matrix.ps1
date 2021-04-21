#!/usr/bin/pwsh
<#
.SYNTAX       simulate-matrix.ps1 
.DESCRIPTION  simulates the Matrix (fun)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

$PathToRepo = "$PSScriptRoot/.."

try {
	write-progress "Reading Data/matrix.csv..."
	$Table = import-csv "$PathToRepo/Data/matrix.csv"

	clear-host
	foreach($Row in $Table) {
		for ($i = 0; $i -lt 4; $i++) {
			write-host -foregroundColor green -noNewline $($Row.A); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.B); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.C); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.D); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.E); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.F); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.G); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.H); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.I); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.J); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.K); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.L); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.M); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.N); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.O); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.P); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.Q); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.R); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.S); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.T); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.U); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.V); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.W); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.X); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.Y); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.Z); start-sleep -milliseconds 1
		}
		write-host ""
	    	start-sleep -milliseconds 200
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
