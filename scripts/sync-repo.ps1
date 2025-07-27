﻿<#
.SYNOPSIS
	Synchronizes a repo 
.DESCRIPTION
	This PowerShell script synchronizes a local Git repository by pull and push (including submodules).
.PARAMETER path
	Specifies the file path to the Git repository (current working directory by default)
.EXAMPLE
	PS> ./sync-repo.ps1 C:\Repos\curl
	⏳ (1/4) Searching for Git executable...  git version 2.42.0.windows.1
	⏳ (2/4) Checking local repository...     C:\Repos\curl
	⏳ (3/4) Pulling remote updates...        Already up to date.
	⏳ (4/4) Pushing local updates...         Everything up-to-date
	✅ Repo 'curl' synchronized in 5s.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/4) Searching for Git executable...  " -noNewline
 	& git --version
 	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/4) Checking local repository...     $path"
	if (!(Test-Path "$path" -pathType container)) { throw "Can't access folder: $path" }

	Write-Host "⏳ (3/4) Pulling remote updates...        " -noNewline
	& git -C "$path" pull --all --recurse-submodules
	if ($lastExitCode -ne 0) { throw "'git pull --all --recurse-submodes' failed" }

	Write-Host "⏳ (4/4) Pushing local updates...         " -noNewline
	& git -C "$path" push
	if ($lastExitCode -ne 0) { throw "'git push' failed" }

	$pathName = (Get-Item "$path").Name
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Repo '$pathName' synchronized in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
