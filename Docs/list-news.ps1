# PowerShell Script /home/mf/PowerShell/Scripts/list-news.ps1

## Synopsis
list-news.ps1 [<RSS-URL>] [<max-count>]

## Description
Lists the latest news

## Syntax
```powershell
/home/mf/PowerShell/Scripts/list-news.ps1 [[-RSS_URL] <String>] [[-MaxCount] <Int32>] [<CommonParameters>]
```

## -RSS_URL &lt;String&gt; Parameter

```
-RSS_URL <String>
    
    Required?                    false
    Position?                    1
    Default value                https://yahoo.com/news/rss/world
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
PS>.\list-news.ps1
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
