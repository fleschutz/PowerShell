<#
.SYNOPSIS
	take-screenshots.ps1 [<TargetDir>] [<Interval>]
.DESCRIPTION
	Takes screenshots and saves them into a target directory (per default every 60 seconds)
.EXAMPLE
	PS> ./take-screenshots C:\Temp 60
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$TargetDir = "$PWD", [int]$Interval = 60) # in seconds

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
	do {
		$Time = (Get-Date)
		$Filename = "$($Time.Year)-$($Time.Month)-$($Time.Day)-$($Time.Hour)-$($Time.Minute)-$($Time.Second).png"
		$FilePath = (Join-Path $TargetDir $Filename)

		write-output "Saving screenshot to $FilePath..."
		TakeScreenshot $FilePath
		Start-Sleep -Seconds $Interval
	} while (1)
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
