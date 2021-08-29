# PowerShell Script /home/mf/PowerShell/Scripts/list-sql-tables.ps1

## Synopsis
list-sql-tables.ps1

## Description
Lists all tables in a SQL server database and exports the list as CSV.
Install-Module InvokeQuery
Run the above command if you do not have this module

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-sql-tables.ps1 [-server] <Object> [-database] <Object> [-username] <Object> [-password] <Object> [<CommonParameters>]
```

## -server &lt;Object&gt; Parameter

```
-server <Object>
    
    Required?                    true
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -database &lt;Object&gt; Parameter

```
-database <Object>
    
    Required?                    true
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -username &lt;Object&gt; Parameter

```
-username <Object>
    
    Required?                    true
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -password &lt;Object&gt; Parameter

```
-password <Object>
    
    Required?                    true
    Position?                    4
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\list-sql-tables.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
