# Help for inspect-exe.ps1 PowerShell Script

## Synopsis & Description
```powershell
inspect-exe.ps1 [<path-to-exe-file>]
```

Prints basic information of the given executable file.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/inspect-exe.ps1 [[-PathToExe] <String>] [<CommonParameters>]
```

```
-PathToExe <String>
    
    Required?                    false
    Position?                    1
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
PS>.\inspect-exe.ps1 C:\MyApp.exe
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of inspect-exe.ps1 by convert-ps2md.ps1*
