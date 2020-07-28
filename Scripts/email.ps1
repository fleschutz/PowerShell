mtpServer = "smtp.example.com"
$msg = new-object Net.Mail.MailMessage
$smtp = new-object Net.Mail.SmtpClient($smtpServer)
$msg.From = "me@example.com"
$msg.ReplyTo = "me@example.com"
$msg.To.Add("you@example.com")
$msg.subject = "Test Mail"
$msg.body = "This is a test mail."
$smtp.Send($msg)
