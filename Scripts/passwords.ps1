#!/snap/bin/powershell
#
# Syntax:	./passwords.ps1
# Description:	generates and prints a list of new passwords
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$NumPasswords = 20
$CharsPerPassword = 15
$MinCharCode = 33
$MaxCharCode = 126

function new_password() {
	$password = ""
	$generator = New-Object System.Random
	for ($i = 0; $i -lt $CharsPerPassword; $i++) {
		$password = $password +[char]$generator.next($MinCharCode,$MaxCharCode)
	}
	return $password
}

for ($j = 0; $j -lt $NumPasswords; $j++) {
	$password = new_password
	write-output $password
}
exit 0
