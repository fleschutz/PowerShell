# PowerShell Script /home/mf/PowerShell/Scripts/search-filename.ps1

## Synopsis
search-filename.ps1

## Description
This script serves as a quick Powershell replacement to the search functionality in Windows.
After you pass in a root folder and a search term, the script will list all files and folders matching that phrase.

## Syntax
```powershell
/home/mf/PowerShell/Scripts/search-filename.ps1 [-path] <Object> [-term] <Object> [<CommonParameters>]
```

## -path &lt;Object&gt; Parameter

```
-path <Object>
    
    Required?                    true
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -term &lt;Object&gt; Parameter

```
-term <Object>
    
    Required?                    true
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\search-filename.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
