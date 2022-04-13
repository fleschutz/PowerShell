<#
.SYNOPSIS
	Sends an email message
.DESCRIPTION
	This PowerShell script sends an email message.
.EXAMPLE
	PS> ./send-email
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

$smtpServer = "smtp.example.com"
$From = read-host "Enter sender email address"
$To = read-host "Enter recipient email address"
$Subject = read-host "Enter subject"
$Body = read-host "Enter message"

try {
	$msg = new-object Net.Mail.MailMessage
	$smtp = new-object Net.Mail.SmtpClient($smtpServer)
	$msg.From = $From
	$msg.ReplyTo = $From
	$msg.To.Add($To)
	$msg.subject = $Subject
	$msg.body = $Body
	$smtp.Send($msg)
	"✔️  Message sent."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
