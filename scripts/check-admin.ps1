<#
.SYNOPSIS
        Check for admin rights
.DESCRIPTION
        This PowerShell script checks if the user has administrator rights.
.EXAMPLE
        PS> ./check-admin.ps1
        ✅ Yes, Markus has admin rights.
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
			"✅ Yes, $USERNAME has admin rights."
		} elseif ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Guest)) {
			"⚠️ No, $USERNAME, has guest rights only."
		} else {
			"⚠️ No, $USERNAME has normal user rights only."
		}
	}  
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}	
