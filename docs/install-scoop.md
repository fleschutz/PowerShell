The *install-scoop.ps1* Script
===========================

install-scoop.ps1 


Parameters
----------
```powershell


[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Script Content
--------------
```powershell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

*(page generated by convert-ps2md.ps1 as of 06/22/2025 10:37:36)*
