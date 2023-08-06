<#
.SYNOPSIS
	Lists PI
.DESCRIPTION
	This PowerShell script calculates and lists the digits of the mathematical constant PI.
.PARAMETER digits
	Specifies the number of digits to list (1000 by default)
.EXAMPLE
	PS> ./list-pi.ps1
	3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$Digits = 1000)

function List-Pi ( $Digits ) {
	$Big = [bigint[]](0..10)
 
	$ndigits = 0
 
 	$q = $t = $k = $Big[1]
 	$r =           $Big[0]
	$l = $n =      $Big[3]

	# calculate first digit
	$nr = ( $Big[2] * $q + $r ) * $l
	$nn = ( $q * ( $Big[7] * $k + $Big[2] ) + $r * $l ) / ( $t * $l )
	$q *= $k
	$t *= $l
	$l += $Big[2]
	$k = $k + $Big[1]
	$n = $nn
	$r = $nr
 
 	Write-Host "$($n)." -noNewline
 	$ndigits++
 
 	$nr = $Big[10] * ( $r - $n * $t )
 	$n = ( ( $Big[10] * ( 3 * $q + $r ) ) / $t ) - 10 * $n
 	$q *= $Big[10]
 	$r = $nr
 
 	while ($ndigits -lt $Digits) {
		if ($Big[4] * $q + $r - $t -lt $n * $t) {
			Write-Host "$n" -noNewline
			$ndigits++
			$nr = $Big[10] * ( $r - $n * $t )
			$n = ( ( $Big[10] * ( 3 * $q + $r ) ) / $t ) - 10 * $n
			$q *= $Big[10]
			$r = $nr
		} else {
			$nr = ( $Big[2] * $q + $r ) * $l
			$nn = ( $q * ( $Big[7] * $k + $Big[2] ) + $r * $l ) / ( $t * $l )
			$q *= $k
			$t *= $l
			$l += $Big[2]
			$k = $k + $Big[1]
			$n = $nn
			$r = $nr
		}
      }
	Write-Host "...  ($Digits digits)"
}

try {
	List-Pi $Digits
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
