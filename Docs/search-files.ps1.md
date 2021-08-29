# PowerShell Script /home/mf/PowerShell/Scripts/search-files.ps1

## Synopsis
search-files.ps1 [<pattern>] [<path>]

## Description
Searches for the given pattern in the given files

## Syntax
```powershell
/home/mf/PowerShell/Scripts/search-files.ps1 [[-Pattern] <String>] [[-Path] <String>] [<CommonParameters>]
```

## -Pattern &lt;String&gt; Parameter

```
-Pattern <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -Path &lt;String&gt; Parameter

```
-Path <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\search-files.ps1 UFO C:\Temp\*.txt
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
