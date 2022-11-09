<#
.SYNOPSIS
	Writes code
.DESCRIPTION
	This PowerShell script writes PowerShell code on the console (fun).
.EXAMPLE
	PS> ./write-code
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetRandomCodeLine { 
	$Generator = New-Object System.Random
	$Num = [int]$Generator.next(0, 15)
	switch($Num) {
	 0 { return "`$count = 0" }
	 1 { return "`$count++" }
	 2 { return "exit 0 # success" }
	 3 { return "`$Files = Get-ChildItem C:" }
	 4 { return "Start-Sleep 1" }
	 5 { return "`$Generator = New-Object System-Random" }
	 6 { return "try {" }
	 7 { return "} catch {" }
	 8 { return "}" }
	 9 { return "Write-Host `"Hello World`" " }
	10 { return "while (`$true) {" }
	11 { return "# next part:" }
	12 { return "exit 1 # failed" }
	13 { return "return 1" }
	14 { return "return 0" }
	}
}

try {
	Write-Host -foreground green "try {"
	while ($true) {
		Write-Host -foreground green "$(GetRandomCodeLine)"
		Start-Sleep -milliseconds 500
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}