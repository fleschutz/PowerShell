<#
.SYNOPSIS
	Sends an email message
.DESCRIPTION
	This script sends an email message.
.EXAMPLE
	PS> ./send-email
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
