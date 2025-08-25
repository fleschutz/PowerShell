<#
.SYNOPSIS
	Lists a directory tree
.DESCRIPTION
	This PowerShell script lists all files and folders in a directory tree (including icon and size).
.PARAMETER path
	Specifies the file path to the directory tree
.EXAMPLE
	PS> ./list-dir-tree.ps1 C:\MyFolder
	├📂Results
	│ ├📄sales.txt (442K)
	   (2 folders, 1 file, 442K total)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

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
	".png"	{return "📸"}
	".rar"  {return "🎁"}
	".tar"  {return "🎁"}
	".zip"  {return "🎁"}
	default {return "📄"}
	}
}

function Bytes2String([int64]$bytes) {
	if ($bytes -lt 1000) { return "$bytes bytes" }
	$bytes /= 1000
	if ($bytes -lt 1000) { return "$($bytes)K" }
	$bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)MB" }
        $bytes /= 1000
        if ($bytes -lt 1000) { return "$($bytes)GB" }
        $bytes /= 1000
	return "$($Bytes)TB"
}

function ListDir([string]$path, [int]$depth) {
	$items = Get-ChildItem -path $path
	foreach($item in $items) {
		Write-Host "  " -noNewline
		for ([int]$i = 1; $i -lt $depth; $i++) { Write-Host "│  " -noNewline }
		if ($item.Mode -like "d*") {
			Write-Host "├📂$($item.Name)"
			ListDir "$path\$($item.Name)" ($depth + 1)
		} else {
			Write-Host "├$(GetFileIcon $item.Extension)$($item.Name) ($(Bytes2String $item.Length))"
			$global:files++
			$global:bytes += $item.Length
		}
	}
	$global:folders++
	if ($depth -gt $global:depth) { $global:depth = $depth }
}

try {
	Write-Host "`n 📂$path"
	[int64]$global:files = $global:folders = $global:depth = $global:bytes = 0
	ListDir $path 1
	"     ($($global:files) files, $($global:folders) folders, depth $($global:depth), $(Bytes2String $global:bytes) total)"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
