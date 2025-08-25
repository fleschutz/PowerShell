<#
.SYNOPSIS
	Writes code
.DESCRIPTION
	This PowerShell script generates and writes PowerShell code on the console (no AI, just for fun).
.PARAMETER color
	Specifies the text color to use ("green" by default)
.PARAMETER speed
	Specifies the speed in milliseconds per code line (500 by default)
.EXAMPLE
	PS> ./write-code.ps1
	try {
	...
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$color = "green", [int]$speed = 200) # milliseconds

function GetCodeLine { 
	$generator = New-Object System.Random
	$number = [int]$generator.next(0, 42)
	switch($number) {
	 0 { return "`$count = 0" }
	 1 { return "`$count++" }
	 2 { return "exit 0 # success" }
	 3 { return "`$files = Get-ChildItem C:" }
	 4 { return "Start-Sleep -seconds 1" }
	 5 { return "`$generator = New-Object System-Random" }
	 6 { return "} else {" }
	 7 { return "} catch {" }
	 8 { return "} elseif (`$count -eq 0) {" }
	 9 { return "Write-Host `"Hello World`" " }
	10 { return "while (`$true) {" }
	11 { return "# next part:" }
	12 { return "exit 1 # failed" }
	13 { return "return 1" }
	14 { return "return 0" }
	15 { return "Write-Progress `"Working...`" " }
	16 { return "[bool]`$keepAlive = `$true" }
	17 { return "for ([int]`$i = 0; `$i -lt 42; `$i++) {" }
	18 { return "`$stopWatch = [system.diagnostics.stopwatch]::startNew()" }
	19 { return "[int]`$elapsed = `$stopWatch.Elapsed.TotalSeconds" }
	20 { return "if (`$count -eq 42) {" }
	21 { return "} finally {" }
	22 { return "throw `"Can't open file`" " }
	23 { return "Start-Sleep -milliseconds 42" }
	24 { return "`$choice = Read-Host `"Red or blue pill?`"" }
	25 { return "[int]`$answer = 42" }
	26 { return "}" }
	27 { return "try {" }
	28 { return "foreach(`$row in `$table) {" }
	29 { return "foreach(`$column in `$row) {" }
	30 { return "foreach(`$file in `$files) {" }
	31 { return "foreach(`$line in `$file) {" }
	32 { return "foreach(`$word in `$file) {" }
	33 { return "foreach(`$character in `$word) {" }
	34 { return "}" }
	35 { return "`$a,`$b = `$b,`$a" }
	36 { return "do {" }
	37 { return "} while (`$false)" }
	38 { return "`$count += 42" }
	39 { return "foreach (`$item in (Get-Process)) {" }
	40 { return "}" }
	41 { return "}" }
	42 { return "}" }
	}
}

try {
	Write-Host -foreground $color "#"
	Write-Host -foreground $color "# Copyright © 2025 by AI. All software pirates will be hacked :-)"
	Write-Host -foreground $color "#"
	[int]$indent = 0
	while ($true) {
		$line = GetCodeLine
		if ($line.Substring(0,1) -eq "}") {
			$indent--
		}
		for ([int]$i = 0; $i -lt $indent; $i++) {
			Write-Host "  " -noNewline
		}
		Write-Host "$line" -foreground $color
		if ($line.Substring($line.length-1,1) -eq "{") {
			$indent++
		}
		Start-Sleep -milliseconds $speed
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
