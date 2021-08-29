# PowerShell Script /home/mf/PowerShell/Scripts/list-tags.ps1

## Synopsis
list-tags.ps1 [<repo-dir>] [<pattern>]

## Description
Lists all tags in the current/given Git repository

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-tags.ps1 [[-RepoDir] <String>] [[-Pattern] <String>] [<CommonParameters>]
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

## -Pattern &lt;String&gt; Parameter

```
-Pattern <String>
    
    Required?                    false
    Position?                    2
    Default value                *
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\list-tags.ps1 C:\MyRepo
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
