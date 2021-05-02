<#
.SYNTAX       generate-qrcode.ps1 [<text>] [<image-size>]
.DESCRIPTION  generates a QR code
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Text = "", $ImageSize = "")
if ($Text -eq "") { $Text = read-host "Enter text or URL" }
if ($ImageSize -eq "") { $ImageSize = read-host "Enter image size (e.g. 500x500)" }

try {
	$ECC = "M" # can be L, M, Q, H
	$QuietZone = 1
	$ForegroundColor = "000000"
	$BackgroundColor = "ffffff"
	$FileFormat = "jpg"
	$PathToRepo = "$PSScriptRoot/.."
	$NewFile = "$PathToRepo/Data/qrcode.jpg"

	$WebClient = new-object System.Net.WebClient
	$WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $Text + "&ecc=" + $ECC +`
		"&size=" + $ImageSize + "&qzone=" + $QuietZone + `
		"&color=" + $ForegroundColor + "&bgcolor=" + $BackgroundColor.Text + `
		"&format=" + $FileFormat), $NewFile)

	write-host -foregroundColor green "Done - QR code has been written to $NewFile"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
