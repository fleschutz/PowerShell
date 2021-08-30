# Help for translate-file.ps1 PowerShell Script

## Synopsis & Description
```powershell
translate-file.ps1 [<file>] [<source-lang>] [<target-lang>]
```

Translates the given text file into another language and prints the result.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/translate-file.ps1 [[-File] <String>] [[-SourceLang] <String>] [[-TargetLang] <String>] [<CommonParameters>]
```

```
-File <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-SourceLang <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-TargetLang <String>
    
    Required?                    false
    Position?                    3
    Default value                
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
PS>.\translate-file.ps1 C:\Memo.txt en de
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of translate-file.ps1 by convert-ps2md.ps1*
