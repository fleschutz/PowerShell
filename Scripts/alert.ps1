<#
.SYNTAX       alert.ps1 [<message>]
.DESCRIPTION  handle and escalate the given alert message
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Message = "")

if ($Message -eq "" ) {
	$URL = read-host "Enter alert message"
}

try {
	echo "ALERT: $Message"

	curl --header "Access-Token: o.PZl5XCp6SBl4F5PpaNXGDfFpUJZKAlEb" --header "Content-Type: application/json" --data-binary '{"type": "note", "title": "ALERT", "body": "$Message"}' --request POST https://api.pushbullet.com/v2/pushes

	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
