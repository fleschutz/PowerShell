<#
.SYNOPSIS
	Saves a single screenshot
.DESCRIPTION
	This PowerShell script takes a single screenshot and saves it into a target folder (the user's pictures folder by default).
.PARAMETER TargetFolder
	Specifies the target folder (the user's pictures folder by default)
.EXAMPLE
	PS> ./save-screenshot
 	✔️ screenshot saved to C:\Users\Markus\Pictures\2021-10-10T14-33-22.png
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$TargetFolder = "$HOME/Pictures")

function TakeScreenshot { param([string]$FilePath)
	Add-Type -Assembly System.Windows.Forms            
	$ScreenBounds = [Windows.Forms.SystemInformation]::VirtualScreen
	$ScreenshotObject = New-Object Drawing.Bitmap $ScreenBounds.Width, $ScreenBounds.Height
	$DrawingGraphics = [Drawing.Graphics]::FromImage($ScreenshotObject)
	$DrawingGraphics.CopyFromScreen( $ScreenBounds.Location, [Drawing.Point]::Empty, $ScreenBounds.Size)
	$DrawingGraphics.Dispose()
	$ScreenshotObject.Save($FilePath)
	$ScreenshotObject.Dispose()
}

try {
        if (-not(test-path "$TargetFolder" -pathType container)) {
                throw "Target folder at 📂$TargetFolder doesn't exist"
        }
	$Time = (Get-Date)
	$Filename = "$($Time.Year)-$($Time.Month)-$($Time.Day)T$($Time.Hour)-$($Time.Minute)-$($Time.Second).png"
	$FilePath = (Join-Path $TargetFolder $Filename)
	TakeScreenshot $FilePath

	"✔️ screenshot saved to $FilePath"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
