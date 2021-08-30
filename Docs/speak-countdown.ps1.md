# Help for speak-countdown.ps1 PowerShell Script

## Synopsis & Description
```powershell
speak-countdown.ps1 [start-number]
```

Speaks a countdown by text-to-speech (TTS).

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/speak-countdown.ps1 [[-StartNumber] <Int32>] [<CommonParameters>]
```

```
-StartNumber <Int32>
    
    Required?                    false
    Position?                    1
    Default value                10
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
[<CommonParameters>]
    This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Example
```powershell
PS>.\speak-countdown.ps1 60
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of speak-countdown.ps1 by convert-ps2md.ps1*
