<#
.SYNOPSIS
	Lists the PowerShell cheat sheet
.DESCRIPTION
	This PowerShell script lists the PowerShell cheat sheet.
.EXAMPLE
	PS> ./list-cheat-sheet.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

"PowerShell Cheat Sheet"
"======================"
""
"Basic Commands"
"--------------"
"         Cmdlet : Commands built into shell written in .NET"
"      Functions : Commands written in PowerShell language"
"      Parameter : Argument to a Cmdlet/Function/Script"
"          Alias : Shortcut for a Cmdlet or Function"
"        Scripts : Text files with .ps1 extension"
"   Applications : Existing windows programs"
"      Pipelines : Pass objects Get-process word | Stop-Process"
"         Ctrl+c : Interrupt current command"
"     Left/right : Navigate editing cursor"
"Ctrl+left/right : Navigate a word at a time"
"     Home / End : End Move to start / end of line"
"      Up / down : Move up and down through history"
"         Insert : Toggles between insert/overwrite mode"
"             F7 : Command history in a window"
"Tab / Shift-Tab : Command line completion"
""
"Variables"
"---------"
"             `$var = `"string`" : Assign variable"
"`$a,`$b = 0 or `$a,`$b = 'a','b' : Assign multiple variables"
"               `$a,`$b = `$b,`$a : Flip variables"
"                 `$var=[int]5 : Strongly typed variable"
""
exit 0 # success
