# PowerShell Script list-empty-files.ps1

## Synopsis & Description
```powershell
list-empty-files.ps1 [<dir-tree>]
```

Lists empty files within the given directory tree.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-empty-files.ps1 [[-DirTree] <String>] [<CommonParameters>]
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
[<CommonParameters>]
    This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

## Example
```powershell
PS>.\list-empty-files.ps1 C:\
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-empty-files.ps1 by convert-ps2md.ps1*
