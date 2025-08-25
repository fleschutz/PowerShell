<#
.SYNOPSIS
        Moves the mouse pointer
.DESCRIPTION
        This PowerShell script moves the mouse pointer either to the given x/y coordinate or just slightly.
.PARAMETER x
        Specifies the x coordinate in pixels
.PARAMETER y
        Specifies the y coordinate in pixels
.EXAMPLE
        PS> ./move-mouse-pointer.ps1 100 100
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([int]$x = -1, [int]$y = -1)

try {
	Add-Type -AssemblyName System.Windows.Forms

	if (($x -eq -1) -and ($y -eq -1)) {
		$Pos = [System.Windows.Forms.Cursor]::Position
		$x = $pos.X + 5
		$y = $pos.Y + 5
	}
	[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
