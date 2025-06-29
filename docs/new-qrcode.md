The *new-qrcode.ps1* Script
===========================

This PowerShell script generates a new QR code image file.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/new-qrcode.ps1 [[-text] <String>] [[-imageSize] <String>] [[-fileFormat] <String>] [<CommonParameters>]

-text <String>
    Specifies the text to use
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-imageSize <String>
    Specifies the image size (width x height)
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

-fileFormat <String>
    Specifies the image file format
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Aliases                      
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./new-qrcode.ps1 "Fasten seatbelt" 500x500 JPG

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Creates a QR code
.DESCRIPTION
	This PowerShell script generates a new QR code image file.
.PARAMETER text
	Specifies the text to use
.PARAMETER imageSize
	Specifies the image size (width x height)
.PARAMETER fileFormat
	Specifies the image file format
.EXAMPLE
	PS> ./new-qrcode.ps1 "Fasten seatbelt" 500x500 JPG
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "", [string]$imageSize = "", [string]$fileFormat = "")

try {
	if ($text -eq "") { $text = Read-Host "Enter text or URL" }
	if ($imageSize -eq "") { $imageSize = Read-Host "Enter image size, e.g. 500x500" }
	if ($fileFormat -eq "") { $fileFormat = Read-Host "Enter the image file format, e.g. JPG" }

	$ECC = "M" # can be L, M, Q, H
	$QuietZone = 1
	$ForegroundColor = "000000"
	$BackgroundColor = "ffffff"
        if ($IsLinux) {
                $pathToPictures = Resolve-Path "$HOME/Pictures"
        } else {
                $pathToPictures = [Environment]::GetFolderPath('MyPictures')
        }
        if (-not(Test-Path "$pathToPictures" -pathType container)) { throw "Pictures folder at 📂$Path doesn't exist (yet)" }
	$newFile = "$pathToPictures/QR_code.$fileFormat"

	$WebClient = New-Object System.Net.WebClient
	$WebClient.DownloadFile(("http://api.qrserver.com/v1/create-qr-code/?data=" + $text + "&ecc=" + $ECC +`
		"&size=" + $imageSize + "&qzone=" + $QuietZone + `
		"&color=" + $ForegroundColor + "&bgcolor=" + $BackgroundColor.Text + `
		"&format=" + $fileFormat), $newFile)

	"✅ New QR code saved as: $newFile"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:39)*
