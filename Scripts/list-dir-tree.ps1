<#
.SYNOPSIS
	Lists a directory tree
.DESCRIPTION
	This PowerShell script lists all files and folders in a directory tree.
.PARAMETER DirTree
	Specifies the path to the directory tree
.EXAMPLE
	PS> ./list-dir-tree C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$DirTree = "$PWD")

function GetFileIcon { param([string]$Suffix)
	switch ($Suffix) {
	".csv"	{return "📊"}
	".epub"	{return "📓"}
	".exe"  {return "⚙️"}
	".gif"	{return "📸"}
	".iso"	{return "📀"}
	".jpg"	{return "📸"}
	".mp3"	{return "🎵"}
	".mkv"	{return "🎬"}
	".zip"  {return "🎁"}
	default {return "📄"}
	}
}

function ListDir { param([string]$Directory, [int]$Depth)
	$Depth++
	$Items = Get-ChildItem -path $Directory
	foreach($Item in $Items) {
		$Filename = $Item.Name
		for ($i = 1; $i -lt $Depth; $i++) { Write-Host "│ " -noNewline }
		if ($Item.Mode -like "d*") {
			Write-Host "├" -noNewline
			Write-Host -foregroundColor green "📂$Filename"
			ListDir "$Directory\$Filename" $Depth
			$global:Dirs++
		} else {
			$Icon = GetFileIcon $Item.Extension
			Write-Host "├$($Icon)$Filename ($($Item.Length) bytes)"
			$global:Files++
			$global:Bytes += $Item.Length
		}
	}
}

try {
	[int]$global:Dirs = 1
	[int]$global:Files = 0
	[int]$global:Bytes = 0
	ListDir $DirTree 0
	" ($($global:Dirs) folders, $($global:Files) files, $($global:Bytes) bytes in total)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
