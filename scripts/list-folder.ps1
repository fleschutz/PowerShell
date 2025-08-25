<#
.SYNOPSIS
	Lists a folder
.DESCRIPTION
	This PowerShell script lists the content of a directory (alphabetically formatted in columns).
.PARAMETER SearchPattern
	Specifies the search pattern (default is "*" which means anything)
.EXAMPLE
	PS> ./list-folder.ps1 C:\*
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$searchPattern = "*")

function GetFileIcon([string]$suffix) {
	switch ($suffix) {
	".csv"	{return "📊"}
	".epub"	{return "📓"}
	".exe"  {return "⚙️"}
	".gif"	{return "📸"}
	".iso"	{return "📀"}
	".jpg"	{return "📸"}
	".mp3"	{return "🎵"}
	".mkv"	{return "🎬"}
	".ps1"  {return "⚙️"}
	".zip"  {return "🎁"}
	default {return "📄"}
	}
}

function ListFolder([string]$searchPattern) {
	$items = Get-ChildItem -path "$searchPattern"
	foreach ($item in $items) {
		$name = $item.Name
		if ($name[0] -eq '.') { continue } # hidden file/dir
		if ($item.Mode -like "d*") { $icon = "📂" } else { $icon = GetFileIcon $item.Extension }
		New-Object PSObject -property @{ Name = "$icon$name" }
	}
}

try {
	ListFolder $searchPattern | Format-Wide -autoSize
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
