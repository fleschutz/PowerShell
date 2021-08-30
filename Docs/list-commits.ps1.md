# PowerShell Script list-commits.ps1

## Synopsis & Description
```powershell
list-commits.ps1 [<RepoDir>] [<Format>]
```

Lists all commits in a Git repository (format is: list|compact|normal|JSON).

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/list-commits.ps1 [[-RepoDir] <String>] [[-Format] <String>] [<CommonParameters>]
```

```
-RepoDir <String>
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-Format <String>
    
    Required?                    false
    Position?                    2
    Default value                list
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
PS>.\list-commits.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of list-commits.ps1 by convert-ps2md.ps1*
