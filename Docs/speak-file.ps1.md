# PowerShell Script /home/mf/PowerShell/Scripts/speak-file.ps1

## Synopsis
speak-file.ps1 [<file>]

## Description
Speaks the content of the given text file by text-to-speech (TTS)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/speak-file.ps1 [[-File] <String>] [<CommonParameters>]
```

## -File &lt;String&gt; Parameter

```
-File <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\speak-file.ps1 C:\MyFile.txt
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
