# PowerShell Script /home/mf/PowerShell/Scripts/fetch-repos.ps1

## Synopsis
fetch-repos.ps1 [<parent-dir>]

## Description
Fetches updates for all Git repositories under the current/given directory (including submodules)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/fetch-repos.ps1 [[-ParentDir] <String>] [<CommonParameters>]
```

## -ParentDir &lt;String&gt; Parameter

```
-ParentDir <String>
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\fetch-repos.ps1 C:\MyRepos
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
