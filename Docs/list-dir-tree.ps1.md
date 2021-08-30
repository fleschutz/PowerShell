# Help for list-dir-tree.ps1 PowerShell Script

## Synopsis & Description
```powershell
list-dir-tree.ps1 [<dir-tree>]
```

Lists the full directory tree.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-dir-tree.ps1 [[-DirTree] <String>] [<CommonParameters>]
```

```
-DirTree <String>
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
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
PS>.\list-dir-tree.ps1 C:\
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-dir-tree.ps1 by convert-ps2md.ps1*
