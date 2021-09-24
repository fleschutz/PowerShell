<#
.SYNOPSIS
	list-os-updates.ps1 [<RSS-URL>] [<max-count>]
.DESCRIPTION
	Lists the latest operating system updates
.EXAMPLE
	PS> ./list-os-updates
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RSS_URL = "https://distrowatch.com/news/dwd.xml", [int]$MaxCount = 20)

try {
	& "$PSScriptRoot/write-big.ps1" "OS Updates"
	[xml]$Content = (invoke-webRequest -URI $RSS_URL).Content
	"`t(by $($Content.rss.channel.title))"

	[int]$Count = 0
	foreach ($item in $Content.rss.channel.item) {
		"`t→ $($item.title)"
		$Count++
		if ($Count -eq $MaxCount) { break }
	}
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
