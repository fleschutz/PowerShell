#!/snap/bin/powershell
<#
.SYNTAX         ./take-screenshot.ps1 [<directory>]
.DESCRIPTION	takes a single screenshots and saves it into the current/given directory
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Directory = "")

function GetTimedScreenshots {
    [CmdletBinding()] Param(
            [Parameter(Mandatory=$True)]             
            [ValidateScript({Test-Path -Path $_ })]
            [string]$Path, 

            [Parameter(Mandatory=$True)]             
            [int32]$Interval,

            [Parameter(Mandatory=$True)]             
            [string]$EndTime    
            )
    
        function GenScreenshot {
           $ScreenBounds = [Windows.Forms.SystemInformation]::VirtualScreen
           $ScreenshotObject = New-Object Drawing.Bitmap $ScreenBounds.Width, $ScreenBounds.Height
           $DrawingGraphics = [Drawing.Graphics]::FromImage($ScreenshotObject)
           $DrawingGraphics.CopyFromScreen( $ScreenBounds.Location, [Drawing.Point]::Empty, $ScreenBounds.Size)
           $DrawingGraphics.Dispose()
           $ScreenshotObject.Save($FilePath)
           $ScreenshotObject.Dispose()
        }

    Add-Type -Assembly System.Windows.Forms            

    do {
	$Time = (Get-Date)
	$FileName = "$($Time.Year)-$($Time.Month)-$($Time.Day)-$($Time.Hour)-$($Time.Minute)-$($Time.Second).png"
	[string]$FilePath = (Join-Path $Path $FileName)

	write-output "Saving screenshot to $FilePath..."
	GenScreenshot

	Start-Sleep -Seconds $Interval
    } while ((Get-Date -Format HH:%m) -lt $EndTime)
}

try {
	if ($Directory -eq "") {
		$Directory = "$PWD"
	}
	GetTimedScreenshots $Directory 0 "00:00"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
