<#
.SYNOPSIS
	Handles and escalates an alert 
.DESCRIPTION
	This PowerShell script handles and escalates the given alert message.
.PARAMETER message
	Specifies the alert message
.EXAMPLE
	PS> ./alert.ps1 "Harddisk failure"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$Message = "")

try {
	if ($Message -eq "" ) { $URL = read-host "Enter alert message" }

	echo "ALERT: $Message"

	curl --header "Access-Token: o.PZl5XCp6SBl4F5PpaNXGDfFpUJZKAlEb" --header "Content-Type: application/json" --data-binary '{"type": "note", "title": "ALERT", "body": "$Message"}' --request POST https://api.pushbullet.com/v2/pushes

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
