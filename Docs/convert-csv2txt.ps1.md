# PowerShell Script /home/mf/PowerShell/Scripts/convert-csv2txt.ps1

## Synopsis
convert-csv2txt.ps1 [<csv-file>]

## Description
Converts the given CSV file into a text list

## Syntax
```powershell
/home/mf/PowerShell/Scripts/convert-csv2txt.ps1 [[-Path] <String>] [<CommonParameters>]
```

## -Path &lt;String&gt; Parameter

```
-Path <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\convert-csv2txt.ps1 salaries.csv
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
