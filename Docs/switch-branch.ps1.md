# PowerShell Script /home/mf/PowerShell/Scripts/switch-branch.ps1

## Synopsis
switch-branch.ps1 [<branch-name>] [<repo-dir>]

## Description
Switches the branch in the current/given Git repository (including submodules)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/switch-branch.ps1 [[-BranchName] <String>] [[-RepoDir] <String>] [<CommonParameters>]
```

## -BranchName &lt;String&gt; Parameter

```
-BranchName <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -RepoDir &lt;String&gt; Parameter

```
-RepoDir <String>
    
    Required?                    false
    Position?                    2
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\switch-branch.ps1 main C:\MyRepo
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
