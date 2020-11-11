#!/snap/bin/powershell

# Syntax:	./alert.ps1 <message>
# Description:	sends the given alert message
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

echo "ALERT"

curl --header "Access-Token: o.PZl5XCp6SBl4F5PpaNXGDfFpUJZKAlEb" --header "Content-Type: application/json" --data-binary '{"type": "note", "title": "ALERT", "body": "Intruder alert"}' --request POST https://api.pushbullet.com/v2/pushes

exit 0
