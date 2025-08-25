<#
.SYNOPSIS
        Plays Jingle Bells
.DESCRIPTION
        This PowerShell script plays the famous Jingle Bells song.
.EXAMPLE
        PS> ./play-jingle-bells.ps1
	(listen and enjoy)
.LINK
        https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$Notes = New-Object -TypeName psobject -Property @{
    REST    = 0
    GbelowC = 196
    A       = 220
    Asharp  = 233
    B       = 247
    C       = 262
    Csharp  = 277
    D       = 294
    Dsharp  = 311
    E       = 330
    F       = 349
    Fsharp  = 370
    G       = 392
    Gsharp  = 415
    AA      = 440
    AAsharp = 466
    BB      = 493
    CC      = 523
    CCsharp = 554
    DD      = 587
    DDsharp = 622
    EE      = 659
    FF      = 698
    FFsharp = 740
    GG      = 784
    GGsharp = 830
    }
$Duration = New-Object -TypeName psobject -Property @{
    WHOLE     = 1600
    HALF      = 800
    QUARTER   = 400
    EIGHTH    = 200
    SIXTEENTH = 100
    }

try {
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.C, $Duration.HALF   )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.D, $Duration.HALF   )
	Start-Sleep -m $Duration.EIGHTH
	[System.Console]::Beep($Notes.D, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.E, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.E, $Duration.HALF)
	Start-Sleep -m $Duration.EIGHTH
	[System.Console]::Beep($Notes.E, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.C, $Duration.HALF   )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.C, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.D, $Duration.HALF   )
	Start-Sleep -m $Duration.QUARTER
	[System.Console]::Beep($Notes.D, $Duration.EIGHTH )
	[System.Console]::Beep($Notes.E, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.DD, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.HALF)
	[System.Console]::Beep($Notes.CC, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	Start-Sleep -m $Duration.EIGHTH
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.AA, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.HALF)
	[System.Console]::Beep($Notes.CC, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.AA, $Duration.HALF)
	Start-Sleep -m $Duration.EIGHTH
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.QUARTER)
	[System.Console]::Beep($Notes.AA, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.AA, $Duration.EIGHTH)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.CC, $Duration.QUARTER)
	[System.Console]::Beep($Notes.BB, $Duration.QUARTER)
	[System.Console]::Beep($Notes.G, $Duration.QUARTER)
	[System.Console]::Beep($Notes.F, $Duration.HALF)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
