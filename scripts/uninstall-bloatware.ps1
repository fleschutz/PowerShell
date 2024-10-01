<#
.SYNOPSIS
        Uninstalls bloatware
.DESCRIPTION
        This PowerShell script uninstalls unnecessary software and applications.
.EXAMPLE
        PS> ./uninstall-bloatware.ps1
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
        Author: Markus Fleschutz | License: CC0
#>

"⏳ (1/3) Removing System Applications..."
winget uninstall 'OMEN Audio Control'
winget uninstall 'OMEN Gaming Hub'
winget uninstall 'Clipchamp'
winget uninstall 'Cortana'
winget uninstall 'Microsoft News'
winget uninstall 'MSN Weather'
winget uninstall 'Get Help'
winget uninstall 'Microsoft Tips'
winget uninstall 'Office'
winget uninstall 'Microsoft.Office'
winget uninstall 'Microsoft Solitaire Collection'
winget uninstall 'Solitaire & Casual Games'
winget uninstall 'Microsoft Sticky Notes'
winget uninstall 'Paint'
winget uninstall 'Microsoft People'
winget uninstall 'Power Automate'
winget uninstall 'Microsoft To Do'
winget uninstall 'Microsoft Photos'
winget uninstall 'Windows Camera'
winget uninstall 'Windows Clock'
winget uninstall 'Windows Calculator'
winget uninstall 'Feedback Hub'
winget uninstall 'Windows Maps'
winget uninstall 'Windows Voice Recorder'
winget uninstall 'Your Phone'
winget uninstall 'Windows Media Player'
winget uninstall 'Movies & TV'
winget uninstall 'Microsoft Family'
winget uninstall 'Quick Assist'
winget uninstall 'Microsoft Teams'
winget uninstall 'Mail and Calendar'
winget uninstall 'Snipping Tool'

"⏳ (2/3) Removing Xbox associated applications..."
winget uninstall 'Xbox'
winget uninstall 'Xbox TCUI'
winget uninstall 'Xbox Game Bar Plugin'
winget uninstall 'Xbox Identity Provider'
winget uninstall 'Xbox Game Speech Window'

"⏳ (3/3) Removing miscellaneous Apps that crowd the Start Menu..."
winget uninstall 'Spotify Music'
winget uninstall 'Messenger'
winget uninstall 'Instagram'
winget uninstall 'Whatsapp'
winget uninstall 'Netflix'
winget uninstall 'LinkedIn'
winget uninstall 'Prime Video for Windows'

"✅ Finished"
exit 0 # success