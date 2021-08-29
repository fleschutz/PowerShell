# PowerShell Script /home/mf/PowerShell/Scripts/convert-mysql2csv.ps1

## Synopsis
convert-mysql2csv.ps1 [<server>] [<database>] [<username>] [<password>] [<query>]

## Description
Convert the MySQL database table to a CSV file

## Syntax
```powershell
/home/mf/PowerShell/Scripts/convert-mysql2csv.ps1 [[-server] <String>] [[-database] <String>] [[-username] <String>] [[-password] <String>] [[-query] <String>] [<CommonParameters>]
```

## -server &lt;String&gt; Parameter

```
-server <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -database &lt;String&gt; Parameter

```
-database <String>
    
    Required?                    false
    Position?                    2
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -username &lt;String&gt; Parameter

```
-username <String>
    
    Required?                    false
    Position?                    3
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -password &lt;String&gt; Parameter

```
-password <String>
    
    Required?                    false
    Position?                    4
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -query &lt;String&gt; Parameter

```
-query <String>
    
    Required?                    false
    Position?                    5
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\convert-mysql2csv.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
