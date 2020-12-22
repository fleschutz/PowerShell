#!/snap/bin/powershell

# Syntax:       ./write-ROT13.ps1 [<text>]
# Description:	encodes or decodes the given text with ROT13
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([String]$Text)

function ROT13 { param([String]$Text)
	$Text.ToCharArray() | ForEach-Object {
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
	if ($Text -eq "" ) {
		[String]$Text = read-host "Enter text to write"
	}
	$Result = ROT13 $Text
	write-output $Result
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
