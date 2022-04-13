<#
.SYNOPSIS
	Lists Outlook's Sent Mails
.DESCRIPTION
	This PowerShell script lists the mails in the Sent Mail folder of Outlook.
.EXAMPLE
	PS> ./list-outlook-sent
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
