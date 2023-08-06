<#
.SYNOPSIS
	Generates a QR code
.DESCRIPTION
	This PowerShell script generates a new QR code image file.
.PARAMETER Text
	Specifies the text to use
.PARAMETER ImageSize
	Specifies the image size (width x height)
.EXAMPLE
	PS> ./new-qrcode.ps1 "Fasten seatbelt" 500x500
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
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
        if ($IsLinux) {
                $PathToPics = Resolve-Path "$HOME/Pictures"
        } else {
                $PathToPics = [Environment]::GetFolderPath('MyPictures')
        }
        if (-not(Test-Path "$PathToPics" -pathType container)) {
                throw "Pictures folder at 📂$Path doesn't exist (yet)"
        }
	$NewFile = "$PathToPics/QR_code.jpg"

	$WebClient = new-object System.Net.WebClient
	$WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $Text + "&ecc=" + $ECC +`
		"&size=" + $ImageSize + "&qzone=" + $QuietZone + `
		"&color=" + $ForegroundColor + "&bgcolor=" + $BackgroundColor.Text + `
		"&format=" + $FileFormat), $NewFile)

	"✔️ saved new QR code image file to: $NewFile"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
