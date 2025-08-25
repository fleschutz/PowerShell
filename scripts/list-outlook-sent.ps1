<#
.SYNOPSIS
	Lists Outlook's Sent Mails
.DESCRIPTION
	This PowerShell script lists the mails in the Sent Mail folder of Outlook.
.EXAMPLE
	PS> ./list-outlook-sent.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Outlook = New-Object -com Outlook.application
	$MAPI = $Outlook.GetNameSpace("MAPI")
	$Inbox = $MAPI.GetDefaultFolder(5) # 5 = olFolderSentMail
	$Inbox.items | Select SentOn,Subject | Format-Table -AutoSize
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
