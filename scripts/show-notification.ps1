<#
.SYNOPSIS
	Shows a notification
.DESCRIPTION
	This PowerShell script shows a toast-message notification for the Windows 10 Notification Center.
.PARAMETER text
	Specifies the text to show ('Hello World' by default)
.PARAMETER title
	Specifies the title to show ('NOTE' by default)
.PARAMETER duration
	Specifies the view duration in milliseconds (5000 by default)
.EXAMPLE
	PS> ./show-notification
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "Hello World", [string]$title = "NOTE", [int]$Duration = 5000)

try {
	Add-Type -AssemblyName System.Windows.Forms 
	$global:balloon = New-Object System.Windows.Forms.NotifyIcon
	$path = (Get-Process -id $pid).Path
	$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
	$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
	$balloon.BalloonTipText = $text
	$balloon.BalloonTipTitle = $title 
	$balloon.Visible = $true 
	$balloon.ShowBalloonTip($Duration)
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}