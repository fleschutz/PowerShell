# PowerShell Script /home/mf/PowerShell/Scripts/convert-txt2wav.ps1

## Synopsis
convert-txt2wav.ps1 [<text>] [<wav-file>]

## Description
Converts the given text to a .WAV audio file

## Syntax
```powershell
/home/mf/PowerShell/Scripts/convert-txt2wav.ps1 [[-Text] <String>] [[-WavFile] <String>] [<CommonParameters>]
```

## -Text &lt;String&gt; Parameter

```
-Text <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -WavFile &lt;String&gt; Parameter

```
-WavFile <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\convert-txt2wav.ps1 "Hello World" spoken.wav
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
