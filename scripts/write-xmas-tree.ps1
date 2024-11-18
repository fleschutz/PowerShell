# Writes a christmas tree to terminal
# Variable $Size = (tree_height, trunk_width, trunk_height)
# Variable $XPos = The starting x position on the terminal line
# Variables $colors = List of colors to use
# Random color pattern each execution

param (
    [array]$Size=@(20,8,4),
    [int]$XPos=50, 
    [array]$colors = @("blue", "green", "cyan", "red", "yellow", "magenta"),
    [int]$Idx = (Get-Random -Min 0 -Max ($colors.Length-1)),
    [int]$count = 100,
    [int]$duration = 250  # ms
)

Clear-Host
do {
	[console]::SetCursorPosition(0,0)
	Write-Host "`n`tMerry Christmas and a Happy New Year!`n`n" -foregroundColor Yellow

    for ( $i=1; $i -le $Size[0]; $i++ ) {
        $line = " " * ($XPos - $i) + "*" * ($i * 2)
        $Idx = $Idx % $colors.Length
        Write-Host $line -foregroundColor $colors[$Idx]
        $Idx++
    }  

    for ( $j=1; $j -le $Size[2]; $j++ ){
        $line = " " * ( $XPos - ( $Size[1] / 2 ) ) + "#" * $Size[1]
        Write-Host $line -foregroundColor DarkGreen
    }

	Start-Sleep -milliseconds $duration

	$count--
} while ($count -gt 0)

