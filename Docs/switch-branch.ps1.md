# Help for switch-branch.ps1 PowerShell Script

## Synopsis & Description
```powershell
switch-branch.ps1 [<branch-name>] [<repo-dir>]
```

Switches the branch in the current/given Git repository (including submodules).

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/switch-branch.ps1 [[-BranchName] <String>] [[-RepoDir] <String>] [<CommonParameters>]
```

```
-BranchName <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-RepoDir <String>
    
    Required?                    false
    Position?                    2
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
PS>.\switch-branch.ps1 main C:\MyRepo
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of switch-branch.ps1 by convert-ps2md.ps1*
