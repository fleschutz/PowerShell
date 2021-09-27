<#
.SYNOPSIS
	new-shortcut.ps1 [<shortcut>] [<target>] [<description>]
.DESCRIPTION
	Creates a new shortcut file
.EXAMPLE
	PS> ./new-shortcut C:\Temp\HDD C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$shortcut = "", [string]$target = "", [string]$description)

try {
	if ($shortcut -eq "" ) { $shortcut = read-host "Enter new shortcut filename" }
	if ($target -eq "" ) { $target = read-host "Enter path to target" }
	if ($description -eq "" ) { $description = read-host "Enter description" }

	$sh = new-object -ComObject WScript.Shell
	$sc = $sh.CreateShortcut("$shortcut.lnk")
	$sc.TargetPath = "$target"
	$sc.WindowStyle = "1"
	$sc.IconLocation = "C:\Windows\System32\SHELL32.dll, 3"
	$sc.Description = "$description"
	$sc.save()

	"✔️ created new shortcut $shortcut ⭢ $target"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
