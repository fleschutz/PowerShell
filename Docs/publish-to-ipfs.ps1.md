# PowerShell Script /home/mf/PowerShell/Scripts/publish-to-ipfs.ps1

## Synopsis
publish-to-ipfs.ps1 [<file(s)/dir>] [<to-hash-list>]

## Description
Publishes the given files & folders to IPFS

## Syntax
```powershell
/home/mf/PowerShell/Scripts/publish-to-ipfs.ps1 [[-Files] <String>] [[-HashList] <String>] [[-DF_Hashes] <String>] [<CommonParameters>]
```

## -Files &lt;String&gt; Parameter

```
-Files <String>
    
    Required?                    false
    Position?                    1
    Default value                
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -HashList &lt;String&gt; Parameter

```
-HashList <String>
    
    Required?                    false
    Position?                    2
    Default value                IPFS_hashes.txt
    Accept pipeline input?       false
    Accept wildcard characters?  false
```

## -DF_Hashes &lt;String&gt; Parameter

```
-DF_Hashes <String>
    
    Required?                    false
    Position?                    3
    Default value                file_checksums.xml
    Accept pipeline input?       false
    Accept wildcard characters?  false
```
## <CommonParameters>
This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about_CommonParameters (https://go.microsoft.com/fwlink/?LinkID=113216).

## Example
```powershell
PS>.\publish-to-ipfs.ps1 C:\MyFile.txt
```


## Notes
Author:  Markus Fleschutz
License: CC0

## Related Links
https://github.com/fleschutz/PowerShell

*Created by convert-ps2md.ps1*
