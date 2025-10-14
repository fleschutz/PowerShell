<#
.SYNOPSIS
	List secure passwords
.DESCRIPTION
	This PowerShell script writes a list of secure passwords to the console (for the user to select one).
	NOTE: The new NIST and CISA recommendation of 2024 for very strong passwords is at least 16 characters.
.PARAMETER passwordLength
	Specifies the length of the password (16 by default)
.PARAMETER columns
	Specifies the number of columns (6 by default)
.PARAMETER rows
	Specifies the number of rows (27 by default)
.EXAMPLE
	PS> ./list-passwords.ps1
	P6zYR't)/TrfEMJa    %.]wrp@&w;`Z`Fv$    =q<p_D{J@_WdhLS3    /NMj/R+]su`8D:Fg    [nIR1X"_14W3:Z;K
	9n*w$"#ULlZyyuC:    Z5Otl4mOy]hQ[8zK    .QxJQBHdLtd,Pwnp    :`/M508&!X{D7Ox5    o/kHzwg8khHvMb|#
	zO:B,FsAwt`Jf?V<    ZyU>8},Bvn/)Moqg    ;Kz|I[tG$t"3kj6x    <.<JM0czDuI<8jq)    #v/;BXq|%.;A|vU,
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$passwordLength = 16, [int]$columns = 6, [int]$rows = 27)

try {
	[int]$minCharCode = 33
	[int]$maxCharCode = 126
	$generator = New-Object System.Random
	for ([int]$row = 0; $row -lt $rows; $row++) {
		$line = ""
		for ([int]$col = 0; $col -lt $columns; $col++) {
			for ([int]$i = 0; $i -lt $passwordLength; $i++) {
				$line += [char]$generator.next($minCharCode, $maxCharCode)
			}
			$line += "    "
		}
		Write-Output $line
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
