<#
.SYNOPSIS
	Writes text encoded or decoded with ROT13
.DESCRIPTION
	This PowerShell script writes text encoded or decoded with ROT13.
.PARAMETER text
	Specifies the text to write
.EXAMPLE
	PS> ./write-rot13 "Hello World"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

function ROT13 { param([string]$text)
	$text.ToCharArray() | ForEach-Object {
		if ((([int] $_ -ge 97) -and ([int] $_ -le 109)) -or (([int] $_ -ge 65) -and ([int] $_ -le 77))) {
			$Result += [char] ([int] $_ + 13);
		} elseif ((([int] $_ -ge 110) -and ([int] $_ -le 122)) -or (([int] $_ -ge 78) -and ([int] $_ -le 90))) {
			$Result += [char] ([int] $_ - 13);
		} else {
			$Result += $_
		}        
	}
	return $Result
}

try {
	if ($text -eq "" ) { $text = read-host "Enter text to write" }

	$Result = ROT13 $text
	write-output $Result
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
