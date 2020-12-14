#!/snap/bin/powershell

# Syntax:	./list-passwords.ps1
# Description:	generates and prints a list of new passwords
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$CharsPerPassword = 15
$MinCharCode = 33
$MaxCharCode = 126
$NumLines = 24
$NumColumns = 6

function new_password() {
	$password = ""
	$generator = New-Object System.Random
	for ($i = 0; $i -lt $CharsPerPassword; $i++) {
		$password = $password +[char]$generator.next($MinCharCode,$MaxCharCode)
	}
	return $password
}

try {
	for ($j = 0; $j -lt $NumLines; $j++) {
		for ($k = 0; $k -lt $NumColumns; $k++) {
			$password = new_password
			Write-Host -NoNewline "$password   "
		}
		Write-Host ""
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
