# PowerShell Script /home/mf/PowerShell/Scripts/play-files.ps1

## Synopsis
play-files.ps1 [<pattern>]

## Description
Plays the given audio files (supporting MP3 and WAV format)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/play-files.ps1 [[-Pattern] <String>] [<CommonParameters>]
```

## -Pattern &lt;String&gt; Parameter

```
-Pattern <String>
    
    Required?                    false
    Position?                    1
    Default value                *
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\play-files.ps1 *.mp3
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
