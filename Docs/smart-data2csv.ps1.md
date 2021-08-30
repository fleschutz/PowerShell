# PowerShell Script smart-data2csv.ps1

## Synopsis & Description
```powershell
smart-data2csv.ps1 [<directory>]
```

Converts the S.M.A.R.T. JSON files in the current/given directory to a CSV table for analysis
       (use query-smart-data.ps1 to generate those JSON files).

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/smart-data2csv.ps1 [[-Directory] <String>] [<CommonParameters>]
```

```
-Directory <String>
    
    Required?                    false
    Position?                    1
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
PS>.\smart-data2csv.ps1.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of smart-data2csv.ps1 by convert-ps2md.ps1*
