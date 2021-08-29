# PowerShell Script /home/mf/PowerShell/Scripts/create-branch.ps1

## Synopsis
create-branch.ps1 [<new-branch-name>] [<repo-dir>]

## Description
Creates and switches to a new branch in a Git repository

## Syntax
```powershell
/home/mf/PowerShell/Scripts/create-branch.ps1 [[-NewBranchName] <String>] [[-RepoDir] <String>] [<CommonParameters>]
```

## -NewBranchName &lt;String&gt; Parameter

```
-NewBranchName <String>
    
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
PS>.\create-branch.ps1 moonshot
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
