# PowerShell Script new-shortcut.ps1

## Synopsis & Description
```powershell
new-shortcut.ps1 [<shortcut>] [<target>] [<description>]
```

Creates a new shortcut file.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/new-shortcut.ps1 [[-shortcut] <String>] [[-target] <String>] [[-description] <String>] [<CommonParameters>]
```

```
-shortcut <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-target <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-description <String>
    
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
PS>.\new-shortcut.ps1 C:\Temp\HDD C:\
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of new-shortcut.ps1 by convert-ps2md.ps1*
