<#
.SYNOPSIS
        Check for admin rights
.DESCRIPTION
        This PowerShell script checks if the user has administrator rights.
.EXAMPLE
        PS> ./check-admin.ps1
        ✅ Yes
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

try {
	if ($IsLinux) {
		# todo
	} else {
		$user = [Security.Principal.WindowsIdentity]::GetCurrent()
		$principal = (New-Object Security.Principal.WindowsPrincipal $user)
		if ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
			"✅ Yes"
		} elseif ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Guest)) {
			"⚠️ No, guest rights only"
		} else {
			"⚠️ No, normal user rights only"
		}
	}  
        exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}	
