<#
.SYNOPSIS
        Checks a password
.DESCRIPTION
        This PowerShell script checks the security status of the given password by haveibeenpwned.com
.EXAMPLE
        PS> ./check-password qwerty
	⚠️  Bad password, it's already listed in 10584568 known security breaches!
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$password = "")

function CalculateHashSHA1 ([string]$string) {
    $sha1 = New-Object System.Security.Cryptography.SHA1CryptoServiceProvider
    $encoder = New-Object System.Text.UTF8Encoding
    $bytes = $encoder.GetBytes($string)
    $hash = ($sha1.ComputeHash($bytes) | % { $_.ToString("X2") }) -join ''
    return $hash
}

function Get-PasswordPwnCount { [CmdletBinding()] param([string]$pass)
    $hash  = CalculateHashSHA1 $pass
    try {
        $uri = "https://api.pwnedpasswords.com/range/$($hash.Substring(0,5))"
        $list  = -split (Invoke-RestMethod $uri -Verbose:($PSBoundParameters['Verbose'] -eq $true) -ErrorAction Stop) # split into separate strings
        $pwn = $list | Select-String $hash.Substring(5,35) # grep
        if ($pwn) { $count = [int] ($pwn.ToString().Split(':')[1]) } else { $count = 0 }
        return $count
    }
    catch {
        Write-Error "Error Calling HIBP API"
        return $null
    }
}

try {
	if ($password -eq "") { $password = Read-Host "Enter the password" }
	$NumBreaches = Get-PasswordPwnCount $password
	if ($NumBreaches -eq 0) {
		"👍 Password seems good, it's not listed in any known security breach as of today." 
	} else {
		"⚠️ Bad password, it's listed already in $NumBreaches known security breaches!"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
