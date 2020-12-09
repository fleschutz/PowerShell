#!/snap/bin/powershell

# Syntax:	./alert.ps1 [<message>]
# Description:	handle and escalate the given alert message
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Message)
if ($Message -eq "" ) {
	$URL = read-host "Enter alert message"
}

try {
	echo "ALERT: $Message"

	curl --header "Access-Token: o.PZl5XCp6SBl4F5PpaNXGDfFpUJZKAlEb" --header "Content-Type: application/json" --data-binary '{"type": "note", "title": "ALERT", "body": "$Message"}' --request POST https://api.pushbullet.com/v2/pushes

	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
