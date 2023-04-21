<#
.SYNOPSIS
        Write sine curves
.DESCRIPTION
        This PowerShell script writes sine curves.
.EXAMPLE
        PS> ./write-sine-curves
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

0..1000 | foreach {
	$Value = [int](40 * [math]::sin($_ / 10))
	if ($Value -gt 0) {
		$Line = " "*60+"*"*$value
	} else {
		$Line = " "*(60-(-1*$value))+"*"*($value*-1)
	}
	Write-Host $Line
	Start-Sleep -milliseconds 50
}