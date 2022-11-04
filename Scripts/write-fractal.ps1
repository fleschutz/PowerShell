<#
.SYNOPSIS
        Writes a fractal
.DESCRIPTION
        This PowerShell script writes an animated Mandelbrot fractal.
.EXAMPLE
        PS> ./write-fractal
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function CalculateFractal([float]$left, [float]$top, [float]$xside, [float]$yside, [float]$zoom) { 
	[int]$maxx = $rui.MaxWindowSize.Width
	[int]$maxy = $rui.MaxWindowSize.Height
	[float]$xscale = $xside / $maxx 
	[float]$yscale = $yside / $maxy 
	for ([int]$y = 0; $y -lt $maxy; $y++) { 
		for ([int]$x = 0; $x -lt $maxx; $x++) { 
			[float]$cx = $x * $xscale + $left
			[float]$cy = $y * $yscale + $top
			[float]$zx = 0
			[float]$zy = 0
			for ([int]$count = 0; ($zx * $zx + $zy * $zy -lt 4) -and ($count -lt $MAXCOUNT); $count++) { 
				[float]$tempx = $zx * $zx - $zy * $zy + $cx
				$zy = $zoom * $zx * $zy + $cy
				$zx = $tempx
			} 
			$global:buffer[$y * $maxx + $x] = $([char](65 + $count))
		} 
	}
}

$MAXCOUNT = 30 
$ui = (Get-Host).ui
$rui = $ui.rawui
[float]$left = -1.75 
[float]$top = -0.25 
[float]$xside = 0.25 
[float]$yside = 0.45 
$buffer0 = ""
1..($rui.MaxWindowSize.Width * $rui.MaxWindowSize.Height) | ForEach-Object { $buffer0 += " " }
$global:buffer = $buffer0.ToCharArray()

while ($true) {
	for ([float]$zoom = 4.0; $zoom -gt 1.1; $zoom -= 0.02) {
		CalculateFractal $left $top $xside $yside $zoom
		[console]::SetCursorPosition(0,0)
		[string]$drawscreen = New-Object system.string($global:buffer, 0, $global:buffer.Length)
		Write-Host -foreground green $drawscreen -noNewline
	}
	for ([float]$zoom = 1.1; $zoom -lt 4.0; $zoom += 0.02) {
		CalculateFractal $left $top $xside $yside $zoom
		[console]::SetCursorPosition(0,0)
		[string]$drawscreen = New-Object system.string($global:buffer, 0, $global:buffer.Length)
		Write-Host -foreground green $drawscreen -noNewline
	}
}
exit 0 # success