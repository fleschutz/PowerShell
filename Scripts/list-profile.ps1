#!/bin/powershell
<#
.SYNTAX         ./list-profile.ps1
.DESCRIPTION	lists your PowerShell profile file
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$PathToProfile = "$PROFILE"

	if (test-path $PathToProfile) {
		$Content = get-content $PathToProfile
		write-output "Profile file at: $PathToProfile"
		write-output "$Content"
	} else {
		write-warning "No profile file at: $PathToProfile"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
