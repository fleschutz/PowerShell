<#
.SYNOPSIS
        Show Notification
.DESCRIPTION
        This PowerShell script shows a toast-message notification for the Windows 10 Notification Center.
.EXAMPLE
        PS> ./show-notification "Hello World"
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

param([string]$Text = "Hello World", [string]$Title = "NOTE", [int]$Duration = 5000)

try {
	Add-Type -AssemblyName System.Windows.Forms 
	$global:balloon = New-Object System.Windows.Forms.NotifyIcon
	$path = (Get-Process -id $pid).Path
	$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
	$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
	$balloon.BalloonTipText = $Text
	$balloon.BalloonTipTitle = $Title 
	$balloon.Visible = $true 
	$balloon.ShowBalloonTip($Duration)
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}