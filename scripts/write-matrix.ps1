<#
.SYNOPSIS
        Writes the Matrix
.DESCRIPTION
        This PowerShell script writes the animated Matrix to the console.
.EXAMPLE
        PS> ./write-matrix.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

function NextLetter {
	if ($global:index -eq 6) { $global:index = 0; $global:pos = [int]$global:generator.next(0, $rui.MaxWindowSize.Width) }
	switch($global:index++) {
	0 { return 'X' }
	1 { return 'I' }
	2 { return 'R' }
	3 { return 'T' }
	4 { return 'A' }
	5 { return 'M' }
	}
}

function SetMatrixLine { param([int]$pos, [char]$letter, [int]$width, [int]$height)
	[int]$y = 0
	for ([int]$x = 0; $x -lt $width; $x++) {
		if ($x -eq $pos) {
			$global:matrix[$y * $width + $x] = $letter
		} elseif ([int]$global:generator.next(0, 7) -eq 3) {
			$global:matrix[$y * $width + $x] = [char]$global:generator.next(97, 122);
		} else {
			$global:matrix[$y * $width + $x] = [char]32
		}
	}
}

function MoveMatrixLines { param([int]$width, [int]$height)
	for ([int]$y = ($height - 1); $y -gt 0; $y--) { 
		for ([int]$x = 0; $x -lt $width; $x++) { 
			$global:matrix[$y * $width + $x] = $global:matrix[($y - 1) * $width + $x]
		} 
	}
}

try {
	$ui = (Get-Host).ui
	$rui = $ui.rawui
	[int]$width = $rui.MaxWindowSize.Width
	[int]$height = $rui.MaxWindowSize.Height
	$buffer0 = ""
	1..($width * $height) | foreach { $buffer0 += " " }
	$global:matrix = $buffer0.ToCharArray()
	$global:generator = New-Object System.Random
	$global:pos = [int]$global:generator.next(0, $rui.MaxWindowSize.Width)
	$global:index = 0

	do {	
		[console]::SetCursorPosition(0,0)
		[string]$screen = New-Object system.string($global:matrix, 0, $global:matrix.Length)
		Write-Host $screen -foreground green -background black -noNewline

		$letter = NextLetter
		SetMatrixLine $global:pos $letter $width $height
		MoveMatrixLines $width $height
		Start-Sleep -milliseconds 30
	} while ($true)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
