#!/snap/bin/powershell
<#
.SYNTAX         ./simulate-matrix.ps1 
.DESCRIPTION	simulates the Matrix (fun)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$PathToRepo = "$PSScriptRoot/.."

try {
	write-progress "Reading Data/matrix.csv..."
	$Table = import-csv "$PathToRepo/Data/matrix.csv"

	clear-host
	foreach($Row in $Table) {
		for ($i = 0; $i -lt 4; $i++) {
			write-host -nonewline $($Row.A); start-sleep -milliseconds 5
			write-host -nonewline $($Row.B); start-sleep -milliseconds 5
			write-host -nonewline $($Row.C); start-sleep -milliseconds 5
			write-host -nonewline $($Row.D); start-sleep -milliseconds 5
			write-host -nonewline $($Row.E); start-sleep -milliseconds 5
			write-host -nonewline $($Row.F); start-sleep -milliseconds 5
			write-host -nonewline $($Row.G); start-sleep -milliseconds 5
			write-host -nonewline $($Row.H); start-sleep -milliseconds 5
			write-host -nonewline $($Row.I); start-sleep -milliseconds 5
			write-host -nonewline $($Row.J); start-sleep -milliseconds 5
			write-host -nonewline $($Row.K); start-sleep -milliseconds 5
			write-host -nonewline $($Row.L); start-sleep -milliseconds 5
			write-host -nonewline $($Row.M); start-sleep -milliseconds 5
			write-host -nonewline $($Row.N); start-sleep -milliseconds 5
			write-host -nonewline $($Row.O); start-sleep -milliseconds 5
			write-host -nonewline $($Row.P); start-sleep -milliseconds 5
			write-host -nonewline $($Row.Q); start-sleep -milliseconds 5
			write-host -nonewline $($Row.R); start-sleep -milliseconds 5
			write-host -nonewline $($Row.S); start-sleep -milliseconds 5
			write-host -nonewline $($Row.T); start-sleep -milliseconds 5
			write-host -nonewline $($Row.U); start-sleep -milliseconds 5
			write-host -nonewline $($Row.V); start-sleep -milliseconds 5
			write-host -nonewline $($Row.W); start-sleep -milliseconds 5
			write-host -nonewline $($Row.X); start-sleep -milliseconds 5
			write-host -nonewline $($Row.Y); start-sleep -milliseconds 5
			write-host -nonewline $($Row.Z); start-sleep -milliseconds 5
		}
		write-host ""
	    	start-sleep -milliseconds 200
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
