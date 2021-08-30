# PowerShell Script search-filename.ps1

## Synopsis & Description
```powershell
search-filename.ps1
```

This script serves as a quick Powershell replacement to the search functionality in Windows.
After you pass in a root folder and a search term, the script will list all files and folders matching that phrase.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/search-filename.ps1 [-path] <Object> [-term] <Object> [<CommonParameters>]
```

```
-path <Object>
    
    Required?                    true
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-term <Object>
    
    Required?                    true
    Position?                    2
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
PS>.\search-filename.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of search-filename.ps1 by convert-ps2md.ps1*
