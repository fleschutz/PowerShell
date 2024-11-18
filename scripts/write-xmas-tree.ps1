<#
.SYNOPSIS
        Writes a Xmas tree
.DESCRIPTION
        This PowerShell script writes a christmas tree to the terminal.
.EXAMPLE
        PS> ./write-xmas-tree.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param( [array]$Size=@(21,8,4), # tree height, trunk width, trunk height
       [int]$XPos=50, # starting x position 
       [array]$colors = @("blue", "green", "cyan", "red", "yellow", "magenta"),
       [int]$Idx = (Get-Random -Min 0 -Max ($colors.Length-1)),
       [int]$count = 100,
       [int]$duration = 250)  # ms

Clear-Host
do {
	[console]::SetCursorPosition(0,0)
	Write-Host "`n`t`t`tMerry Christmas" -foregroundColor yellow
	Write-Host "`t`t`t       &"        -foregroundColor yellow     
	Write-Host "`t`t`t Happy New Year" -foregroundColor yellow
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

