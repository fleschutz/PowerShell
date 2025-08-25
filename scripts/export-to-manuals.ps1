<#
.SYNOPSIS
	Exports all scripts as manuals
.DESCRIPTION
	This PowerShell script exports the comment-based help of all PowerShell scripts as manuals.
.EXAMPLE
	PS> ./export-to-manuals.ps1
	⏳ (1/2) Reading PowerShell scripts from /home/mf/PowerShell/scripts/*.ps1 ... 
	⏳ (2/2) Exporting Markdown manuals to /home/mf/PowerShell/docs ...
	✅ Exported 518 Markdown manuals in 28 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 2

param([string]$filePattern = "$PSScriptRoot/*.ps1", [string]$targetDir = "$PSScriptRoot/../docs")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ (1/2) Reading PowerShell scripts from $filePattern ..." 
	$scripts = Get-ChildItem "$filePattern"

	"⏳ (2/2) Exporting Markdown manuals to $targetDir ..."
	foreach ($script in $scripts) {
		& "$PSScriptRoot/convert-ps2md.ps1" "$script" > "$targetDir/$($script.BaseName).md"
	}

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Exported $($scripts.Count) Markdown manuals in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
