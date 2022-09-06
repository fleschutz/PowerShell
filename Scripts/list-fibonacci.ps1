<#
.SYNOPSIS
	Lists the Fibonacci numbers
.DESCRIPTION
	This PowerShell script lists the Fibonacci numbers.
.EXAMPLE
	PS> ./list-fibonacci
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function fibonacci($n) {
    if ($n -lt 2) { return 1 }
    return (fibonacci($n - 1)) + (fibonacci($n - 2))
}


foreach ($i in 0..100) {
    Write-Host "$(fibonacci $i), " -noNewline
}
exit 0 # success
