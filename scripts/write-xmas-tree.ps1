# Prints a christmas tree to terminal
# Variable $Size = (tree_height, trunk_width, trunk_height)
# Variable $XPos = The starting x position on the terminal line
# Variables $Colors = List of colors to use
# Random color pattern each execution

# Examples:
#PSXmasTree.ps1    #default
#PSXmasTree.ps1 -Size 20,8,4 -Count 20 -Duration 800   #big tree
#PSXmasTree.ps1 -Size 3,2,1 -XPos 20   #totes adorbs baby tree

param (
    [array]$Size=@(10,2,2),
    [int]$XPos=50, 
    [array]$Colors = @("blue", "green", "cyan", "red", "yellow", "magenta"),
    [int]$Idx = (Get-Random -Min 0 -Max ($Colors.Length-1)),
    [int]$Count = 10,
    [int]$Duration = 500
)

while ( $Count -gt 0 ) {

    Clear-Host

    Write-Host "`n`n`n"

    for ( $i=1; $i -le $Size[0]; $i++ ) {
        $Line = " " * ($XPos - $i) + "*" * ($i * 2)
        $Idx = $Idx % $Colors.Length
        Write-Host $Line -ForegroundColor $Colors[$Idx]
        $Idx++
    }  

    for ( $j=1; $j -le $Size[2]; $j++ ){
        $Line = " " * ( $XPos - ( $Size[1] / 2 ) ) + "#" * $Size[1]
        Write-Host $Line -ForegroundColor White
    }

    Start-Sleep -Milliseconds $Duration

    $Count--

}

Write-Host "Merry Christmas!" -ForegroundColor Green