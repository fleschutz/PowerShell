<#
.SYNOPSIS
	Play the Snake game
.DESCRIPTION
	This PowerShell script lets you play the famous Snake game.
	NOTE: use the arrow keys to control the snake
.EXAMPLE
	PS> ./play-snake.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$w=($q=($u=$Host.UI.RawUi).WindowSize).Width-1
$u.CursorSize=0
$a=0..($q.Height-1)|%{$i=$_;0..$w|%{@{X=$_;Y=$i}}};$s=($f=$n=$a[($x=$y=$d=3)]),$n

function Z($c,$t) {
	$u.CursorPosition=$c
	Write-Host $t -N
}

while(0..$w-contains$x-and($b=$x+$y*($w+1))-ge0-and($n=$a[$b])-and$s-notcontains$n) {
	Z $n "X"
	sleep -M 99
	while($u.KeyAvailable-and1..4-contains($k=$u.ReadKey(15).VirtualKeyCode-36)-and$d%2-ne$k%2) {
		$d=$k
	}
	switch($d) {
	1 { --$x }
	2 { --$y }
	3 { ++$x }
	4 { ++$y }
	}
	$s+=$n
	if ($s-contains$f) {
		$f=$a|random
	} else {
		$p,$s=$s
		Z $p ' '
	}
	Z $f "🔶"
}

Write-Host "`n---------`nGAME OVER`n---------"
exit 0 # success