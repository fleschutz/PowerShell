The *convert-image2ascii.ps1* Script
===========================

convert-image2ascii.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Converts images to ASCII art
.DESCRIPTION
	This PowerShell script converts an image to ASCII art.
.EXAMPLE
	PS> ./convert-image2ascii -InFile "C:\Folder\Image.jpg" -Width 32 -Height 32
.NOTES
	Author: Fxbyy
 #>
 
 function Convert-ImageToAscii {
    [CmdletBinding(DefaultParameterSetName = 'AutoSize')]
    param (
        [Parameter(Mandatory = $true)]
        [string] $InFile,

        [Parameter(Mandatory = $false, ParameterSetName = 'CustomSize')]
        [int] $Width,

        [Parameter(Mandatory = $false, ParameterSetName = 'CustomSize')]
        [int] $Height,

        [Parameter(Mandatory = $false)]
        [switch] $Invert
    )
 
    begin {
        $tempFile = "$PSScriptRoot\temp.jpg"
        [void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

        $img = [System.Drawing.Image]::FromFile((Get-Item $InFile))

        if ($PSCmdlet.ParameterSetName -eq 'AutoSize') {
            [int]$Height = $Host.UI.RawUI.WindowSize.Height * ($img.Size.Width / $img.Size.Height)
            [int]$Width = $Height * ($img.Size.Width / $img.Size.Height)
        } else {
            if ($null -eq $Height -or $Height -eq 0) {
                [int]$Height = $Width * ($img.Size.Height / $img.Size.Width)
            } elseif ($null -eq $Width -or $Width -eq 0) {
                [int]$Width = $Height * ($img.Size.Width / $img.Size.Height)
            }
        }
    }
 
    process {
        $bmp = New-Object System.Drawing.Bitmap($Width, $Height)

        $graph = [System.Drawing.Graphics]::FromImage($bmp)
        $graph.DrawImage($img, 0, 0, $Width, $Height)

        $graph.Dispose()
        $img.Dispose()

        if ($Invert) {
            $symbols = " .,:~+t?xmoX#M%@"
        } else {
            $symbols = "@%M#Xomx?t+~:,. "
        }
        $res = ""

        foreach ($h in 1..$bmp.Height) {
            foreach ($w in 1..$bmp.Width) {
                $px = $bmp.GetPixel($w - 1, $h - 1)
                $brightness = (0.2126 * $px.R + 0.7152 * $px.G + 0.0722 * $px.B)

                if ($brightness -le 15) { $res += $symbols[0] + " " } 
                elseif ($brightness -le 31) { $res += $symbols[1] + " " }
                elseif ($brightness -le 47) { $res += $symbols[2] + " " }
                elseif ($brightness -le 63) { $res += $symbols[3] + " " }
                elseif ($brightness -le 79) { $res += $symbols[4] + " " }
                elseif ($brightness -le 95) { $res += $symbols[5] + " " }
                elseif ($brightness -le 111) { $res += $symbols[6] + " " }
                elseif ($brightness -le 127) { $res += $symbols[7] + " " }
                elseif ($brightness -le 143) { $res += $symbols[8] + " " }
                elseif ($brightness -le 159) { $res += $symbols[9] + " " }
                elseif ($brightness -le 175) { $res += $symbols[10] + " " }
                elseif ($brightness -le 191) { $res += $symbols[11] + " " }
                elseif ($brightness -le 207) { $res += $symbols[12] + " " }
                elseif ($brightness -le 223) { $res += $symbols[13] + " " }
                elseif ($brightness -le 249) { $res += $symbols[14] + " " }
                else { $res += $symbols[15] + " " }

            }
            $res += "`n"
        }
    }
 
    end {
        $BitMap.Dispose()
        Remove-Item $tempFile -Force

        $res
    }
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:35)*
