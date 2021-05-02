<#
.SYNTAX       create-shortcut.ps1 [<shortcut>] [<target>] [<description>]
.DESCRIPTION  creates a new shortcut
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Shortcut = "", $Target = "", $Description)
if ($Shortcut -eq "" ) { $Shortcut = read-host "Enter filename of shortcut" }
if ($Target -eq "" ) { $Target = read-host "Enter path to target" }
if ($Description -eq "" ) { $Description = read-host "Enter description" }

try {
	$sh = new-object -ComObject WScript.Shell
	$shortcut = $sh.CreateShortcut("$Shortcut.lnk")
	$shortcut.TargetPath = "$Target"
	$shortcut.WindowStyle = "1"
	$shortcut.IconLocation = "C:\Windows\System32\SHELL32.dll, 3"
	$shortcut.Description = "$Description"
	$shortcut.save()

	write-host -foregroundColor green "✔️ shortcut $Shortcut created."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
