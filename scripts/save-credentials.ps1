<#
.SYNOPSIS
	Saves credentials encrypted
.DESCRIPTION
	This PowerShell script asks for credentials and saves them encrypted into a target file ("$HOME\my.credentials" by default).
.PARAMETER TargetFile
	Specifies the target file ("$HOME\my.credentials" by default)
.EXAMPLE
	PS> ./save-credentials.ps1
	Enter username and password, please.
 	✔️ Your credentials have been saved encrypted into C:\Users\Markus\my.credentials
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$TargetFile = "$HOME\my.credentials")

try {
	Write-Host "Enter username and password, please." -foreground red
	$cred = Get-Credential
	$cred.Password | ConvertFrom-SecureString | Set-Content "$TargetFile"
	"✔️ Your credentials have been saved encrypted into $TargetFile"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
