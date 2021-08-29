# PowerShell Script /home/mf/PowerShell/Scripts/translate-file.ps1

## Synopsis
translate-file.ps1 [<file>] [<source-lang>] [<target-lang>]

## Description
Translates the given text file into another language and prints the result

## Syntax
```powershell
/home/mf/PowerShell/Scripts/translate-file.ps1 [[-File] <String>] [[-SourceLang] <String>] [[-TargetLang] <String>] [<CommonParameters>]
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

## -SourceLang &lt;String&gt; Parameter

```
-SourceLang <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -TargetLang &lt;String&gt; Parameter

```
-TargetLang <String>
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\translate-file.ps1 C:\Memo.txt en de
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
