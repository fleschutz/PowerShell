<#
.SYNOPSIS
	Lists Outlook's Inbox 
.DESCRIPTION
	This PowerShell script lists the emails in the inbox of Outlook.
.EXAMPLE
	PS> ./list-outlook-inbox.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$Outlook = New-Object -com Outlook.application
	$MAPI = $Outlook.GetNameSpace("MAPI")
	$Inbox = $MAPI.GetDefaultFolder(6) # 6 = olFolderInbox
	$Inbox.items | Select Received,Subject | Format-Table -AutoSize
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
