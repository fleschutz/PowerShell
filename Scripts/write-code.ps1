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

param([string]$color = "green", [int]$speed = 500) # milliseconds

[string]$global:Tabs = ""

function GetRandomCodeLine { 
	$Generator = New-Object System.Random
	$Num = [int]$Generator.next(0, 31)
	switch($Num) {
	 0 { return $Tabs + "`$count = 0" }
	 1 { return $Tabs + "`$count++" }
	 2 { return $Tabs + "exit 0 # success" }
	 3 { return $Tabs + "`$files = Get-ChildItem C:" }
	 4 { return $Tabs + "Start-Sleep -seconds 1" }
	 5 { return $Tabs + "`$generator = New-Object System-Random" }
	 6 { $global:Tabs = "        "; return "} else {" }
	 7 { $global:Tabs = "        "; return "} catch {" }
	 8 { $global:Tabs = "        "; return "} elseif (`$count -eq 0) {" }
	 9 { return $Tabs + "Write-Host `"Hello World`" " }
	10 { $global:Tabs = "        "; return "while (`$true) {" }
	11 { return $Tabs + "# next part:" }
	12 { return $Tabs + "exit 1 # failed" }
	13 { return $Tabs + "return 1" }
	14 { return $Tabs + "return 0" }
	15 { return $Tabs + "Write-Progress `"Working...`" " }
	16 { return $Tabs + "[bool]`$keepAlive = `$true" }
	17 { return $Tabs + "# Copyright © 2023 write-code.ps1. All Rights Reserved." }
	18 { $global:Tabs = "        "; return "for ([int]`$i = 0; `$i -lt 42; `$i++) {" }
	19 { return $Tabs + "`$stopWatch = [system.diagnostics.stopwatch]::startNew()" }
	20 { return $Tabs + "[int]`$elapsed = `$stopWatch.Elapsed.TotalSeconds" }
	21 { $global:Tabs = "        "; return "if (`$count -eq 42) {" }
	22 { $global:Tabs = "        "; return "} finally {" }
	23 { return $Tabs + "throw `"Can't open file`" " }
	24 { return $Tabs + "Start-Sleep -milliseconds 42" }
	25 { return $Tabs + "`$Choice = Read-Host `"Red or blue pill?`"" }
	26 { return $Tabs + "[int]`$answer = 42" }
	27 { $global:Tabs = ""; return "}" }
	28 { $global:Tabs = "         "; return "try {" }
	29 { $global:Tabs = "         "; return "foreach(`$row in `$table) {" }
	30 { $global:Tabs = "         "; return "foreach(`$file in `$files) {" }
	}
}

try {
	while ($true) {
		Write-Host -foreground $color "$(GetRandomCodeLine)"
		Start-Sleep -milliseconds $speed
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
