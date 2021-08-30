# Help for list-unused-files.ps1 PowerShell Script

## Synopsis & Description
```powershell
list-unused-files.ps1 <dir-tree> <days>
```

Lists files in the <directory tree> with last access time older than <days>.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-unused-files.ps1 [[-DirTree] <String>] [[-NumberOfDaysUnused] <Int32>] [<CommonParameters>]
```

```
-DirTree <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-NumberOfDaysUnused <Int32>
    
    Required?                    false
    Position?                    2
    Default value                99
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
PS>.\list-unused-files.ps1 C:\ 90
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-unused-files.ps1 by convert-ps2md.ps1*
