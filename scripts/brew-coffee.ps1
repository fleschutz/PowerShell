$host.UI.RawUI.WindowTitle = "Homebrew Coffee 🍵"

$wsh = New-Object -ComObject WScript.Shell


function Start-CoffeeCupAnimation {
    param (
        [int]$DelayMs = 250
    )

    
    $HideCursor = "`e[?25l" # Hide cursor
    $ShowCursor = "`e[?25h" # Show cursor

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


    $wsh = New-Object -ComObject WScript.Shell
    $f16Job = Start-Job -ScriptBlock {
        param($wshComObject)
        $wshLocal = New-Object -ComObject WScript.Shell

        
        while ($true) {
#            $wshLocal.SendKeys("{F16}")
            Start-Sleep -Seconds 55
        }
    } -ArgumentList $wsh

    Write-Host -NoNewline $HideCursor

    try {
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
    finally {
        Write-Host -NoNewline $ShowCursor
        if ($f16Job) {
            Stop-Job -Job $f16Job
            Remove-Job -Job $f16Job
    }
}

}

Start-CoffeeCupAnimation 
