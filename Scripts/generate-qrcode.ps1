<#
.SYNOPSIS
	generate-qrcode.ps1 [<text>] [<image-size>]
.DESCRIPTION
	Generates a QR code image file.
.EXAMPLE
	PS> .\generate-qrcode.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Text = "", [string]$ImageSize = "")

try {
	if ($Text -eq "") { $Text = read-host "Enter text or URL" }
	if ($ImageSize -eq "") { $ImageSize = read-host "Enter image size (e.g. 500x500)" }

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

	"✔️ wrote QR code to $NewFile"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
