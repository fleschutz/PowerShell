<#
.SYNOPSIS
	Prints a list of random passwords
.DESCRIPTION
	list-passwords.ps1 [<PasswordLength>] [<Columns>] [<Rows>]
.EXAMPLE
	PS> ./list-passwords
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]$PasswordLength = 15, [int]$Columns = 6, [int]$Rows = 30)

$MinCharCode = 33
$MaxCharCode = 126

try {
	write-output ""
	$Generator = New-Object System.Random
	for ($j = 0; $j -lt $Rows; $j++) {
		$Line = ""
		for ($k = 0; $k -lt $Columns; $k++) {
			for ($i = 0; $i -lt $PasswordLength; $i++) {
				$Line += [char]$Generator.next($MinCharCode,$MaxCharCode)
			}
			$Line += "   "
		}
		write-output "$Line"
	}
	write-output ""
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
