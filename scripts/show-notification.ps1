<#
.SYNOPSIS
	Shows a notification
.DESCRIPTION
	This PowerShell script shows a toast-message notification for the Windows Notification Center.
.PARAMETER text
	Specifies the text to show ('Hello World' by default)
.PARAMETER title
	Specifies the title to show ('NOTE' by default)
.PARAMETER duration
	Specifies the view duration in milliseconds (5000 by default)
.EXAMPLE
	PS> ./show-notification.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "Hello World", [string]$title = "NOTE", [int]$duration = 5000)

try {
	Add-Type -AssemblyName System.Windows.Forms 
	$global:balloon = New-Object System.Windows.Forms.NotifyIcon
	$path = (Get-Process -id $pid).Path
	$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
	$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
	$balloon.BalloonTipText = $text
	$balloon.BalloonTipTitle = $title 
	$balloon.Visible = $true 
	$balloon.ShowBalloonTip($duration)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
