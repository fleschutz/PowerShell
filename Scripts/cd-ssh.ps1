<#
.SYNOPSIS
	Sets the working directory to the user's SSH folder
.DESCRIPTION
	This PowerShell script changes the working directory to the user's SSH folder.
.EXAMPLE
	PS> ./cd-ssh
	📂/home/Joe/.ssh
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$Path = resolve-path "$HOME/.ssh"
	if (-not(test-path "$Path" -pathType container)) {
		throw "SSH folder at 📂$Path doesn't exist (yet)"
	}
	set-location "$Path"
	"📂$Path"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
