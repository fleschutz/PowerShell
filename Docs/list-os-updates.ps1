# PowerShell Script /home/mf/PowerShell/Scripts/list-os-updates.ps1

## Synopsis
list-os-updates.ps1 [<RSS-URL>] [<max-count>]

## Description
Lists the latest operating system updates

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-os-updates.ps1 [[-RSS_URL] <String>] [[-MaxCount] <Int32>] [<CommonParameters>]
```

## -RSS_URL &lt;String&gt; Parameter

```
-RSS_URL <String>
    
    Required?                    false
    Position?                    1
    Default value                https://distrowatch.com/news/dwd.xml
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -MaxCount &lt;Int32&gt; Parameter

```
-MaxCount <Int32>
    
    Required?                    false
    Position?                    2
    Default value                20
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\list-os-updates.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
