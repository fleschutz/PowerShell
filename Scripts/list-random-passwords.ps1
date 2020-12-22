#!/snap/bin/powershell

# Syntax:	./list-random-passwords.ps1
# Description:	prints a list of random passwords
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$CharsPerPassword = 15
$MinCharCode = 33
$MaxCharCode = 126
$Lines = 24
$Columns = 6

function GeneratePassword() {
	$password = ""
	$generator = New-Object System.Random
	for ($i = 0; $i -lt $CharsPerPassword; $i++) {
		$password = $password +[char]$generator.next($MinCharCode,$MaxCharCode)
	}
	return $password
}

try {
	for ($j = 0; $j -lt $Lines; $j++) {
		for ($k = 0; $k -lt $Columns; $k++) {
			$password = GeneratePassword
			Write-Host -NoNewline "$password   "
		}
		Write-Host ""
	}
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
