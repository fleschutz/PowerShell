<#
.SYNOPSIS
	Checks credentials 
.DESCRIPTION
	This PowerShell script asks for credentials and checks them against saved ones ("$HOME\my.credentials" by default).
.PARAMETER TargetFile
	Specifies the target file ("$HOME\my.credentials" by default)
.EXAMPLE
	PS> ./check-credentials.ps1
	Enter username and password, please.
 	✅ Your credentials are correct.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$TargetFile = "$HOME\my.credentials")

try {
	Write-Host "Enter username and password, please." -foreground red
	$credsFromUser = Get-Credential

	$secureString = Get-Content "$TargetFile" | ConvertTo-SecureString
	$credsFromFile = New-Object System.Management.Automation.PSCredential($credsFromUser.UserName, $secureString)

	if ($credsFromUser.UserName -ne $credsFromFile.UserName) { throw "Sorry, your username is wrong." }

	$pw1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromUser.Password))
	$pw2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromFile.Password))
	if ($pw1 -cne $pw2) { throw "Sorry, your password is wrong." }

	"✅ Your credentials are correct."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
