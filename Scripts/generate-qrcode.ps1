#!/snap/bin/powershell
<#
.SYNTAX         ./generate-qrcode.ps1 [<text>] [<image-size>]
.DESCRIPTION	generates a QR code
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Text = "http://www.fleschutz.de", $ImageSize = "500x500")
if ($Text -eq "") {
	$Text = read-input "Enter text or URL"
}
if ($ImageSize -eq "") {
	$ImageSize = read-input "Enter image size (e.g. 500x500)"
}
$ECC = "L" # can be L, M, Q, H
$QuietZone = 1
$ForegroundColor = "000000"
$BackgroundColor = "ffffff"
$FileFormat = "jpg"
$PathToRepo=(get-item $MyInvocation.MyCommand.Path).directory.parent
$NewFile = "$PathToRepo/Data/qrcode.jpg"

try {
	$WebClient = new-object System.Net.WebClient
	$WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $Text + "&ecc=" + $ECC +`
		"&size=" + $ImageSize + "&qzone=" + $QuietZone + `
		"&color=" + $ForegroundColor + "&bgcolor=" + $BackgroundColor.Text + `
		"&format=" + $FileFormat), $NewFile)
	write-output "OK - QR code has been written to $NewFile"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
