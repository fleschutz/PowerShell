$null = [Reflection.Assembly]::LoadWithPartialName("System.Speech")

## Create the two main objects we need for speech recognition and synthesis
if (!$global:SpeechModuleListener) {
    ## For XP's sake, don't create them twice...
    $global:SpeechModuleSpeaker = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $global:SpeechModuleListener = New-Object System.Speech.Recognition.SpeechRecognizer
}

$script:SpeechModuleMacros = @{}
## Add a way to turn it off
$script:SpeechModuleMacros.Add("Stop Listening", {$script:listen = $false; Suspend-Listening})
$script:SpeechModuleComputerName = ${env:ComputerName}

function Update-SpeechCommands {
    #.Synopsis 
    #  Recreate the speech recognition grammar
    #.Description
    #  This parses out the speech module macros, 
    #  and recreates the speech recognition grammar and semantic results, 
    #  and then updates the SpeechRecognizer with the new grammar, 
    #  and makes sure that the ObjectEvent is registered.
    $choices = New-Object System.Speech.Recognition.Choices
    foreach ($choice in $script:SpeechModuleMacros.GetEnumerator()) {
        New-Object System.Speech.Recognition.SemanticResultValue $choice.Key, $choice.Value.ToString() |
            ForEach-Object { $choices.Add($_.ToGrammarBuilder()) }
    }

    if ($VerbosePreference -ne "SilentlyContinue") {
        $script:SpeechModuleMacros.Keys |
            ForEach-Object { Write-Host"$Computer, $_" -Fore Cyan }
    }

    $builder = New-Object System.Speech.Recognition.GrammarBuilder"$Computer, "
    $builder.Append((New-ObjectSystem.Speech.Recognition.SemanticResultKey"Commands", $choices.ToGrammarBuilder()))
    $grammar = New-Object System.Speech.Recognition.Grammar $builder
    $grammar.Name = "Power VoiceMacros"

    ## Take note of the events, but only once (make sure to remove the old one)
    Unregister-Event"SpeechModuleCommandRecognized" -ErrorAction SilentlyContinue
    $null = Register-ObjectEvent $grammar SpeechRecognized `
                -SourceIdentifier"SpeechModuleCommandRecognized" `
                -Action {iex $event.SourceEventArgs.Result.Semantics.Item("Commands").Value}

    $global:SpeechModuleListener.UnloadAllGrammars()
    $global:SpeechModuleListener.LoadGrammarAsync($grammar)
}

function Add-SpeechCommands {
    #.Synopsis
    #  Add one or more commands to the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    [CmdletBinding()]
    Param([hashtable]$VoiceMacros,[string]$Computer=$Script:SpeechModuleComputerName)

    ## Add the new macros
    $script:SpeechModuleMacros += $VoiceMacros 
    ## Update the default if they change it, so they only have to do that once.
    $script:SpeechModuleComputerName = $Computer 
    Update-SpeechCommands
}

function Remove-SpeechCommands {
    #.Synopsis
    #  Remove one or more command from the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    Param([string[]]$CommandText)
    foreach ($command in $CommandText) {
        $script:SpeechModuleMacros.Remove($Command)
    }
    Update-SpeechCommands
}

function Clear-SpeechCommands {
    #.Synopsis
    #  Removes all commands from the speech-recognition macros, and update the recognition
    #.Parameter CommandText
    #  The string key for the command to remove
    $script:SpeechModuleMacros = @{}
    ## Default value: A way to turn it off
    $script:SpeechModuleMacros.Add("Stop Listening", {Suspend-Listening})
    Update-SpeechCommands
}

function Start-Listening {
    #.Synopsis
    #  Sets the SpeechRecognizer to Enabled
    $global:SpeechModuleListener.Enabled = $true
    Say "Speech Macros are $($Global:SpeechModuleListener.State)"
    Write-Host "Speech Macros are $($Global:SpeechModuleListener.State)"
}

function Suspend-Listening {
    #.Synopsis
    #  Sets the SpeechRecognizer to Disabled
    $global:SpeechModuleListener.Enabled = $false
    Say "Speech Macros are disabled"
    Write-Host "Speech Macros are disabled"
}


function Out-Speech {
    #.Synopsis
    #  Speaks the input object
    #.Description
    #  Uses the default SpeechSynthesizer settings to speak the string representation of the InputObject
    #.Parameter InputObject
    #  The object to speak 
    #  NOTE: this should almost always be a pre-formatted string,
    #        most objects don't render to very speakable text.
    Param([Parameter(ValueFromPipeline=$true)][Alias("IO")]$InputObject)
    $null = $global:SpeechModuleSpeaker.SpeakAsync(($InputObject | Out-String))
}

function Remove-SpeechXP {
    #.Synopis
    #  Dispose of the SpeechModuleListener and SpeechModuleSpeaker
    $global:SpeechModuleListener.Dispose(); $global:SpeechModuleListener = $null
    $global:SpeechModuleSpeaker.Dispose();  $global:SpeechModuleSpeaker = $null
}

#Set-Alias asc Add-SpeechCommands
#Set-Alias rsc Remove-SpeechCommands
#Set-Alias csc Clear-SpeechCommands
Set-Alias say Out-Speech
#Set-Alias listen Start-Listener
#Export-ModuleMember -Function * -Alias * -VariableSpeechModuleListener, SpeechModuleSpeaker

#Clear-SpeechCommands
Add-SpeechCommands @{
   "What time is it?" = { Say "It is $(Get-Date -f "h:mm tt")" }
   "What day is it?"  = { Say $(Get-Date -f "dddd, MMMM dd") }
   "What's running?"  = {
      $proc = ps | sort ws -desc
      Say $("$($proc.Count) processes, including $($proc[0].name), which is using " +
            "$([int]($proc[0].ws/1mb)) megabytes of memory")
   }
} -Computer "Laptop" -Verbose 

Add-SpeechCommands @{
    "Open Notepad"= { & "C:\Programs\DevTools\Notepad++\notepad++.exe"}
}

Start-Listening

start-sleep 10

exit 0
