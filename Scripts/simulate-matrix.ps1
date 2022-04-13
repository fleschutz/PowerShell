<#
.SYNOPSIS
	Simulates the Matrix (fun)
.DESCRIPTION
	This PowerShell script simulates the Matrix (for fun).
.EXAMPLE
	PS> ./simulate-matrix
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Table = import-csv "$PSScriptRoot/../Data/matrix.csv"

	clear-host
	foreach($Row in $Table) {
		for ($i = 0; $i -lt 4; $i++) {
			write-host -foregroundColor green -noNewline $($Row.A) 
			write-host -foregroundColor green -noNewline $($Row.B)
			write-host -foregroundColor green -noNewline $($Row.C)
			write-host -foregroundColor green -noNewline $($Row.D)
			write-host -foregroundColor green -noNewline $($Row.E)
			write-host -foregroundColor green -noNewline $($Row.F)
			write-host -foregroundColor green -noNewline $($Row.G)
			write-host -foregroundColor green -noNewline $($Row.H); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.I)
			write-host -foregroundColor green -noNewline $($Row.J)
			write-host -foregroundColor green -noNewline $($Row.K)
			write-host -foregroundColor green -noNewline $($Row.L)
			write-host -foregroundColor green -noNewline $($Row.M)
			write-host -foregroundColor green -noNewline $($Row.N)
			write-host -foregroundColor green -noNewline $($Row.O)
			write-host -foregroundColor green -noNewline $($Row.P); start-sleep -milliseconds 1
			write-host -foregroundColor green -noNewline $($Row.Q)
			write-host -foregroundColor green -noNewline $($Row.R)
			write-host -foregroundColor green -noNewline $($Row.S)
			write-host -foregroundColor green -noNewline $($Row.T)
			write-host -foregroundColor green -noNewline $($Row.U)
			write-host -foregroundColor green -noNewline $($Row.V)
			write-host -foregroundColor green -noNewline $($Row.W)
			write-host -foregroundColor green -noNewline $($Row.X)
			write-host -foregroundColor green -noNewline $($Row.Y)
			write-host -foregroundColor green -noNewline $($Row.Z); start-sleep -milliseconds 1
		}
		write-host ""
	    	start-sleep -milliseconds 200
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
