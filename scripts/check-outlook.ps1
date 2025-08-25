<#
.SYNOPSIS
	Checks Outlook's inbox 
.DESCRIPTION
	This PowerShell script checks the inbox of Outlook for new/unread mails.
.EXAMPLE
	PS> ./check-outlook.ps1
	✅ No new mails.
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
	foreach($Mail in $Inbox.Items) {
		if ($Mail.Unread -eq $false) { continue }
		"⚠️ New mail '$($Mail.Subject)' from $($Mail.SenderName)."
		$Unread++
	}
	if ($Unread -eq 0) { "✅ No new mails." }
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
