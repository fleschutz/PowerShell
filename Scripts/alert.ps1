<#
.SYNOPSIS
	alert.ps1 [<message>]
.DESCRIPTION
	Handle and escalate the given alert message.
.EXAMPLE
	PS> .\alert.ps1 "Harddisk failure"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

param([string]$Message = "")

try {
	if ($Message -eq "" ) { $URL = read-host "Enter alert message" }

	echo "ALERT: $Message"

	curl --header "Access-Token: o.PZl5XCp6SBl4F5PpaNXGDfFpUJZKAlEb" --header "Content-Type: application/json" --data-binary '{"type": "note", "title": "ALERT", "body": "$Message"}' --request POST https://api.pushbullet.com/v2/pushes

	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
