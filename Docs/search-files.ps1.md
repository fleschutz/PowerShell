# Help for search-files.ps1 PowerShell Script

## Synopsis & Description
```powershell
search-files.ps1 [<pattern>] [<path>]
```

Searches for the given pattern in the given files.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/search-files.ps1 [[-Pattern] <String>] [[-Path] <String>] [<CommonParameters>]
```

```
-Pattern <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Path <String>
    
    Required?                    false
    Position?                    2
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
PS>.\search-files.ps1 UFO C:\Temp\*.txt
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of search-files.ps1 by convert-ps2md.ps1*
