<#
.SYNOPSIS
	take-screenshot.ps1 [<directory>]
.DESCRIPTION
	Takes a single screenshot and saves it into the current/given directory
.EXAMPLE
	PS> ./take-screenshot C:\Temp
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Directory = "$PWD")

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
	$Time = (Get-Date)
	$Filename = "$($Time.Year)-$($Time.Month)-$($Time.Day)-$($Time.Hour)-$($Time.Minute)-$($Time.Second).png"
	$FilePath = (Join-Path $Directory $Filename)

	write-output "Saving screenshot to $FilePath..."
	TakeScreenshot $FilePath
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
