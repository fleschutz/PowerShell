<#
.SYNOPSIS
	Create and Set Custom Power Plan
.DESCRIPTION
	Creates a custom power plan based on the active power plan, renames it, and sets it as the active power plan.
    This PowerShell script:
    1. Retrieves the active power plan GUID.
    2. Duplicates the active power plan.
    3. Renames the new power plan to a custom name.
    4. Sets the newly created power plan as the active plan.
.EXAMPLE
	PS> ./create-custom-power-plan.ps1


.LINK
	https://github.com/Arash-Seifi/PowerShell
.NOTES
	Author: Arash Seifi | License: CC0
#>


try {
    Add-Type -AssemblyName System.Speech
    
    $Synth = New-Object System.Speech.Synthesis.SpeechSynthesizer

    $Synth.GetInstalledVoices() | 
        Select-Object -ExpandProperty VoiceInfo | 
        Select-Object -Property Name, Culture, Gender, Age
    
    # Indicate success and exit with status 0
    exit 0
} 
catch {
    "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    
    exit 1
}