#!/snap/bin/powershell
<#
.SYNTAX         ./next-joke.ps1 
.DESCRIPTION	gets the next random Juck Norris joke
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	$Response = (invoke-webRequest http://api.icndb.com/jokes/random).Content | ConvertFrom-Json
	$Joke = $Response.value.joke
	write-output "$Text"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
