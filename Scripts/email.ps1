#!/snap/bin/powershell
#
# Syntax:       ./email.ps1 
# Description:	sends an email
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$smtpServer = "smtp.example.com"
$msg = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$msg.From = "me@example.com"
$msg.ReplyTo = "me@example.com"
$msg.To.Add("you@example.com")
$msg.subject = "Test Mail"
$msg.body = "This is a test mail."
$smtp.Send($msg)
