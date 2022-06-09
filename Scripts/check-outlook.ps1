<#
.SYNOPSIS
	Checks Outlook's Inbox 
.DESCRIPTION
	This PowerShell script checks the inbox of Outlook for new mails.
.EXAMPLE
	PS> ./check-outlook
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Add-Type -assembly "Microsoft.Office.Interop.Outlook"
	$Outlook = New-Object -comobject Outlook.Application
	$Namespace = $Outlook.GetNameSpace("MAPI")
	$Inbox = $Namespace.GetDefaultFolder(6) # 6 = olFolderInbox
	[int]$Unread = 0
	$Sender = ""
	[switch]$SameSender = $true
	foreach($Mail in $Inbox.Items) {
		if ($Mail.Unread -eq $false) { continue }
		$Unread++
		if ("$Sender" -eq "") { $Sender = $Mail.SenderName
		} elseif ("$Sender" -ne "$($Mail.SenderName)") { $SameSender = $false }
		$Subject = $Mail.Subject
	}
	if ($Unread -eq 0) {		$Reply = "No new mails."
	} elseif ($Unread -eq 1) {	$Reply = "One new mail from $Sender regarding $Subject."
	} elseif ($SameSender) {	$Reply = "$Unread new mails from $Sender."
	} else {			$Reply = "$Unread new mails."
	}
	"$Reply"
	exit 0 # success
} catch {
	"Sorry: $($Error[0])"
	exit 1
}