<#
.SYNOPSIS
	Saves credentials encrypted
.DESCRIPTION
	This PowerShell script asks for credentials and saves them encrypted into a target file.
.PARAMETER targetFile
	Specifies the target file ("~\my.credentials" by default)
.EXAMPLE
	PS> ./save-credentials.ps1
	Enter username and password, please.
 	✅ Your credentials have been saved to C:\Users\Markus\my.credentials (encrypted).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$targetFile = "~\my.credentials")

try {
	Write-Host "Enter username and password, please." -foreground red
	$cred = Get-Credential
	$cred.Password | ConvertFrom-SecureString | Set-Content "$targetFile"
	"✅ Your credentials have been saved to $targetFile (encrypted)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
