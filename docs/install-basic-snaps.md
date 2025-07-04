The *install-basic-snaps.ps1* Script
===========================

This PowerShell script installs 20 basic snap apps.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/install-basic-snaps.ps1 [<CommonParameters>]

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./install-basic-snaps.ps1
⏳ Installing 20 snap apps (sorted alphabetically)...

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Installs basic Snap apps
.DESCRIPTION
	This PowerShell script installs 20 basic snap apps.
.EXAMPLE
	PS> ./install-basic-snaps.ps1
	⏳ Installing 20 snap apps (sorted alphabetically)...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()
	if (!$IsLinux) { throw "Only Linux currently support snaps" }

	"⏳ Installing 20 snap apps (sorted alphabetically)..."
	& sudo snap install ant
	& sudo snap install audacity
	& sudo snap install bashtop
	& sudo snap install blender --classic
	& sudo snap install chromium
	& sudo snap install cmake
	& sudo snap install cups
	& sudo snap install emacs --classic
	& sudo snap install ffmpeg --edge
	& sudo snap install firefox
	& sudo snap install gimp
	& sudo snap install go
	& sudo snap install gradle --classic
	& sudo snap install groovy --classic
	& sudo snap install hugo
	& sudo snap install jenkins --edge --classic 
	& sudo snap install nano --classic
	& sudo snap install nextcloud
	& sudo snap install node --classic
	& sudo snap install plexmediaserver
	
	[int]$elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Installed 20 snap apps in $($elapsed)s."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:36)*
