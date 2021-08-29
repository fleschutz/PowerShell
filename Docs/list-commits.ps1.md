# PowerShell Script /home/mf/PowerShell/Scripts/list-commits.ps1

## Synopsis
list-commits.ps1 [<repo-dir>] [<format>]

## Description
Lists all commits in the current/given Git repository

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-commits.ps1 [[-RepoDir] <String>] [[-Format] <String>] [<CommonParameters>]
```

## -RepoDir &lt;String&gt; Parameter

```
-RepoDir <String>
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Format &lt;String&gt; Parameter

```
-Format <String>
    
    Required?                    false
    Position?                    2
    Default value                compact
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\list-commits.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
