<#
.SYNOPSIS
	Generates new PIN's
.DESCRIPTION
	This PowerShell script generates a table of random PIN's and writes them to the console (for
	the user to select one).
.PARAMETER pinLength
	Specifies the PIN length (default: 5)
.PARAMETER columns
	Specifies the number of columns (default: 15)
.PARAMETER rows
	Specifies the number of rows (default: 27)
.EXAMPLE
	PS> ./new-pins.ps1
	18055   42534   12845   68646   21478   22841   80575   38416   21424   42627
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$pinLength = 5, [int]$columns = 15, [int]$rows = 27)

try {
	$generator = New-Object System.Random
	for ($i = 0; $i -lt $rows; $i++) {
		$line = ""
		for ($j = 0; $j -lt $columns; $j++) {
			for ($k = 0; $k -lt $pinLength; $k++) {
				$line += [char]$generator.next(48,57) # 48='0', 57='9'
			}
			$line += "   "
		}
		Write-Output $line
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
