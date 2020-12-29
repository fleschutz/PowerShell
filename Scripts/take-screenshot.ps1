#!/snap/bin/powershell
<#
.SYNTAX         ./take-screenshot.ps1
.DESCRIPTION	takes a single screenshots
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

Function Get-TimedScreenshot {
    [CmdletBinding()] Param(
            [Parameter(Mandatory=$True)]             
            [ValidateScript({Test-Path -Path $_ })]
            [string] $Path, 

            [Parameter(Mandatory=$True)]             
            [int32] $Interval,

            [Parameter(Mandatory=$True)]             
            [string] $EndTime    
            )
    
        #Define helper function that generates and saves screenshot
        Function GenScreenshot {
           $ScreenBounds = [Windows.Forms.SystemInformation]::VirtualScreen
           $ScreenshotObject = New-Object Drawing.Bitmap $ScreenBounds.Width, $ScreenBounds.Height
           $DrawingGraphics = [Drawing.Graphics]::FromImage($ScreenshotObject)
           $DrawingGraphics.CopyFromScreen( $ScreenBounds.Location, [Drawing.Point]::Empty, $ScreenBounds.Size)
           $DrawingGraphics.Dispose()
           $ScreenshotObject.Save($FilePath)
           $ScreenshotObject.Dispose()
        }

        Try {
            
            #load required assembly
            Add-Type -Assembly System.Windows.Forms            

            Do {
                #get the current time and build the filename from it
                $Time = (Get-Date)
                
                [string] $FileName = "$($Time.Month)"
                $FileName += '-'
                $FileName += "$($Time.Day)" 
                $FileName += '-'
                $FileName += "$($Time.Year)"
                $FileName += '-'
                $FileName += "$($Time.Hour)"
                $FileName += '-'
                $FileName += "$($Time.Minute)"
                $FileName += '-'
                $FileName += "$($Time.Second)"
                $FileName += '.png'
            
                #use join-path to add path to filename
                [string] $FilePath = (Join-Path $Path $FileName)

                #run screenshot function
                GenScreenshot
                
                write-verbose "Saved screenshot to $FilePath. Sleeping for $Interval seconds"

                Start-Sleep -Seconds $Interval
            }

            #note that this will run once regardless if the specified time as passed
            While ((Get-Date -Format HH:%m) -lt $EndTime)
        }

       Catch {write-error "$Error[0].ToString() + $Error[0].InvocationInfo.PositionMessage"}

}
