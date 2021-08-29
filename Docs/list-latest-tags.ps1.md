# PowerShell Script /home/mf/PowerShell/Scripts/list-latest-tags.ps1

## Synopsis
list-latest-tags.ps1 [<parent-dir>]

## Description
Lists the latests tags in all Git repositories under the current/given directory

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-latest-tags.ps1 [[-ParentDir] <String>] [<CommonParameters>]
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
PS>.\list-latest-tags.ps1 C:\MyRepos
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
