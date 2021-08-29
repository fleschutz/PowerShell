# PowerShell Script /home/mf/PowerShell/Scripts/query-smart-data.ps1

## Synopsis
query-smart-data.ps1 [<directory>]

## Description
Queries the S.M.A.R.T. data of your HDD/SSD's and saves it to the current/given directory
(use smart-data2csv.ps1 to generate a CSV table for analysis)

## Syntax
```powershell
/home/mf/PowerShell/Scripts/query-smart-data.ps1 [[-Directory] <String>] [<CommonParameters>]
```

## -Directory &lt;String&gt; Parameter

```
-Directory <String>
    
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
PS>.\query-smart-data.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0
       requires smartctl (smartmontools) and admin rights
       for automation copy this script to /etc/cron.daily

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
