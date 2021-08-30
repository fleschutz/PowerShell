# Help for convert-sql2csv.ps1 PowerShell Script

## Synopsis & Description
```powershell
convert-sql2csv.ps1 [<server>] [<database>] [<username>] [<password>] [<query>]
```

Converts a SQL database table to a .CSV file.

## Syntax & Parameters
```powershell
/home/mf/PowerShell/Scripts/convert-sql2csv.ps1 [[-server] <String>] [[-database] <String>] [[-username] <String>] [[-password] <String>] [[-query] <String>] [<CommonParameters>]
```

```
-server <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-database <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-username <String>
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-password <String>
    
    Required?                    false
    Position?                    4
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

```
-query <String>
    
    Required?                    false
    Position?                    5
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
PS>.\convert-sql2csv.ps1
```


## Notes
Author: Markus Fleschutz · License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Generated from comment-based help of convert-sql2csv.ps1 by convert-ps2md.ps1*
