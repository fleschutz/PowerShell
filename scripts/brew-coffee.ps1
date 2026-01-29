<#
.SYNOPSIS
	Brews coffee as animation
.DESCRIPTION
	This PowerShell script writes a coffee cup with animated steam to the console.
.EXAMPLE
	PS> ./brew-coffee.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function Start-CoffeeCupAnimation { param ([int]$DelayMs = 250)
    
    $CoffeeCup = @(
     "      _________   "
     "  ###|         |  "
     " |   |         |  "
     "  ###|_________|  "
     "     \_________/  "
    )

    $SteamFrames = @(
        # Frame 1
        @(  "                 "
            "                 "
            "       )(   )(   "
            "      (  ) (  )  "
            "       )(   )(   "
        ),
        # Frame 2
        @(
            "                 "
            "                 "
            "      (  ) (  )  "
            "       )(   )(   "
            "      (  ) (  )  "
        )
    )
    $SteamFrameIndex = 0

    while ($true) {
            Clear-Host

            $currentSteam = $SteamFrames[$SteamFrameIndex]
            foreach ($line in $currentSteam) {
                Write-Host $line
            }

            foreach ($line in $CoffeeCup) {
                Write-Host $line
            }

           
            $SteamFrameIndex = ($SteamFrameIndex + 1) % $SteamFrames.Length
            
            Start-Sleep -Milliseconds $DelayMs
        }
}


try {
	Start-CoffeeCupAnimation 

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0])"
	exit 1
}
