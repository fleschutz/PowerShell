<#
.SYNOPSIS
    Local multiplayer chess game in PowerShell.

.DESCRIPTION
    Started off of code from https://github.com/bhassen99/POSH-Chess, which was very
much incomplete. I kept the board shape, but have changed everything else.
The unicode chess pieces unfortunately do not render in the base PowerShell console, 
they only appear when run in PowerShell ISE.

.NOTES
    Name: Chess.ps1
    Version: 0.3.1
    Author: Michael Shen
    Date: 10-19-2017
#>

#Update-Board must be run before Publish-Board
#Draws the board to the screen and displays all the icons
function Publish-Board {
    Clear-Host
    Write-Host "`n`n"
    Write-Host '     A   B   C   D   E   F   G   H'
    Write-Host '   --------------------------------- '
    Write-Host ' 8 |'$board[0,7].Icon'|'$board[1,7].Icon'|'$board[2,7].Icon'|'$board[3,7].Icon'|'$board[4,7].Icon'|'$board[5,7].Icon'|'$board[6,7].Icon'|'$board[7,7].Icon'| 8'
    Write-Host '   --------------------------------- '
    Write-Host ' 7 |'$board[0,6].Icon'|'$board[1,6].Icon'|'$board[2,6].Icon'|'$board[3,6].Icon'|'$board[4,6].Icon'|'$board[5,6].Icon'|'$board[6,6].Icon'|'$board[7,6].Icon'| 7'
    Write-Host '   --------------------------------- '
    Write-Host ' 6 |'$board[0,5].Icon'|'$board[1,5].Icon'|'$board[2,5].Icon'|'$board[3,5].Icon'|'$board[4,5].Icon'|'$board[5,5].Icon'|'$board[6,5].Icon'|'$board[7,5].Icon'| 6'
    Write-Host '   --------------------------------- '
    Write-Host ' 5 |'$board[0,4].Icon'|'$board[1,4].Icon'|'$board[2,4].Icon'|'$board[3,4].Icon'|'$board[4,4].Icon'|'$board[5,4].Icon'|'$board[6,4].Icon'|'$board[7,4].Icon'| 5'
    Write-Host '   --------------------------------- '
    Write-Host ' 4 |'$board[0,3].Icon'|'$board[1,3].Icon'|'$board[2,3].Icon'|'$board[3,3].Icon'|'$board[4,3].Icon'|'$board[5,3].Icon'|'$board[6,3].Icon'|'$board[7,3].Icon'| 4'
    Write-Host '   --------------------------------- '
    Write-Host ' 3 |'$board[0,2].Icon'|'$board[1,2].Icon'|'$board[2,2].Icon'|'$board[3,2].Icon'|'$board[4,2].Icon'|'$board[5,2].Icon'|'$board[6,2].Icon'|'$board[7,2].Icon'| 3'
    Write-Host '   --------------------------------- '
    Write-Host ' 2 |'$board[0,1].Icon'|'$board[1,1].Icon'|'$board[2,1].Icon'|'$board[3,1].Icon'|'$board[4,1].Icon'|'$board[5,1].Icon'|'$board[6,1].Icon'|'$board[7,1].Icon'| 2'
    Write-Host '   --------------------------------- '
    Write-Host ' 1 |'$board[0,0].Icon'|'$board[1,0].Icon'|'$board[2,0].Icon'|'$board[3,0].Icon'|'$board[4,0].Icon'|'$board[5,0].Icon'|'$board[6,0].Icon'|'$board[7,0].Icon'| 1'
    Write-Host '   --------------------------------- '
    Write-Host '     A   B   C   D   E   F   G   H'
}

#Read and clean text input before calling New-Move
Function Read-Input {
    Write-Host ""
    if($Script:whiteTurn) {
        try {
            [ValidateScript({$_.Length -eq 2 -or $_ -like '*resign*'})]$src = Read-Host 'White piece source'
            if ($src -eq 'resign') {
                $Script:gameStatus = [gamestatus]::blackWin
                Update-Log -resign $true
            } else {
                [Int]$cc = Get-Column $src[0]
                [Int]$cr = Get-Row $src[1]
                [ValidateScript({$_.Color -eq 'White'})]$pc = $board[$cc, $cr]
                [ValidateScript({$_.Length -eq 2})]$dst = Read-Host 'White piece destination'
                New-Move $src $dst
            }
        } catch {
            Write-Error "Illegal input: Not a white piece or valid location"
            Write-Error $src
            Read-Input
        }
    } else {
        try {
            [ValidateScript({$_.Length -eq 2 -or $_.Value -eq 'resign'})]$src = Read-Host 'Black piece source'
            if ($src -like '*resign*') {
                $Script:gameStatus = [gamestatus]::whiteWin
                Update-Log -resign $true
            }
            [Int]$cc = Get-Column $src[0]
            [Int]$cr = Get-Row $src[1]
            [ValidateScript({$_.Color -eq 'Black'})]$pc = $board[$cc, $cr]
            [ValidateScript({$_.Length -eq 2})]$dst = Read-Host 'Black piece destination'
            New-Move $src $dst
        } catch {
            Write-Error "Illegal input: Not a black piece or valid location"
            Read-Input
        }
    }
}

#Update the status of all the pieces and place them
function Update-Board {
    #Get arrays of all piece that are still alive
    [Array]$CurrentWhite = $Script:WhitePieces | Where-Object {$_.Alive -eq $true}
    [Array]$CurrentBlack = $Script:BlackPieces | Where-Object {$_.Alive -eq $true}

    #Place all the white pieces
    foreach ($pc in $CurrentWhite) {
        $board[($pc.CurrentColumn),($pc.CurrentRow)] = $pc
    }
    #Place all the black pieces
    foreach ($pc in $CurrentBlack) {
        $board[($pc.CurrentColumn),($pc.CurrentRow)] = $pc
    }

    #Check for spaces without a piece in them, then fill it with the empty placeholder.
    for ($i = 0; $i -le 7; $i++) {
        for ($j = 0; $j -le 7; $j++) {
            if ($board[$i, $j] -eq $null) {
                $board[$i, $j] = $Empty
            }
        }
    }
}

#Used to move pieces on the board
function New-Move {
    param ([string]$src, [string]$dst)

    enum castleOptions {
        none = 0
        kingside = 1
        queenside = 2
    }

    [bool]$attack = $false
    [bool]$moveSuccess = $false
    [int]$castle = [castleOptions]::none
    [bool]$promote = $false
    [bool]$ep = $false
    [bool]$check = $false

    try {
        [Int]$CurrentColumn = Get-Column $src[0]
        [Int]$CurrentRow = Get-Row $src[1]
        [Int]$DesiredColumn = Get-Column $dst[0]
        [Int]$DesiredRow = Get-Row $dst[1]

        $pc = $board[$CurrentColumn, $CurrentRow]
    } catch {
        Write-Error "Out of bounds"
        Read-Input
    }

    #Moving nothing, nowhere, or trying to capture your own piece
    if ($board[$CurrentColumn, $CurrentRow] -eq $Empty) {
        Write-Error "There is nothing there."
        Read-Input
    } elseif (($CurrentRow -eq $DesiredRow) -and ($CurrentColumn -eq $DesiredColumn)) {
        Write-Error "That wouldn't move anywhere."
        Read-Input
    } elseif ($board[$DesiredColumn, $DesiredRow] -ne $Empty -and `
              $pc.Color -eq $board[$DesiredColumn, $DesiredRow].Color) {
        Write-Error "Collision with own team"
        Read-Input
    } else {
        [int]$MoveX = $DesiredColumn - $CurrentColumn
        [int]$MoveY = $DesiredRow - $CurrentRow

        #Move verification logic for each piece
        switch ($pc.GetType().Name) {
            'Pawn' {
                $MoveX = [math]::abs($MoveX)

                #Pawns can max move one to the side when capturing, two forward when moving
                if (($MoveX -gt 1) -or ([math]::abs($MoveY) -gt 2)) {
                    Write-Error "Illegal Pawn Move: Too many spaces"
                } else {
                    #Force pawns to only move "forward"
                    if ($pc.Color -eq 'Black') {
                        $MoveY *= -1
                    }

                    if ($MoveX -eq 0) {
                        if ($board[$DesiredColumn, $DesiredRow] -eq $Empty) {
                            if ($MoveY -eq 1) {
                                $moveSuccess = $true
                                $pc.firstmove = $false
                            } elseif ($MoveY -eq 2 -and $pc.firstmove -eq $true) {
                                if ($board[$DesiredColumn, ($DesiredRow + 1)] -eq $Empty) {
                                    $moveSuccess = $true
                                    $pc.firstmove = $false
                                    $pc.inpassing = $Script:turnCounter
                                } else {
                                    Write-Error "Illegal Pawn Move: Blocked Path"
                                }
                            } else {
                                Write-Error "Illegal Pawn Move: Cannot Move 2 Spaces"
                            }
                        } else {
                            Write-Error "Illegal Pawn Move: Blocked Path"
                        }
                    } elseif (($MoveX -eq 1) -and ($MoveY -eq 1)) {
                        if ($board[$DesiredColumn, $DesiredRow] -eq $Empty) {
                            $enpassant = $board[$DesiredColumn, $CurrentRow]
                            if (($enpassant.GetType().Name -eq 'Pawn') -and `
                                ($pc.Color -ne $enpassant.Color) -and `
                                ($enpassant.inpassing -eq ($Script:turnCounter - 1))) {
                                
                                $moveSuccess = $true
                                $attack = $true
                                $ep = $true
                                
                                $enpassant.Alive = $false
                                $enpassant.CurrentPosition = $null
                                $enpassant.CurrentRow = $null
                                $enpassant.CurrentColumn = $null
                                $board[$DesiredColumn, $CurrentRow] = $Empty
                            } else {
                                Write-Error 'Illegal Pawn Move: Cannot Capture en passant'
                            }
                        } else {
                            $attack = $true
                            $moveSuccess = $true
                            $pc.firstmove = $false
                        }
                    } else {
                        #Catch-all, should never get here
                        Write-Error "Illegal Pawn Move"
                    }
                }
            }

            'Knight' {
                $MoveX = [math]::abs($MoveX)
                $MoveY = [math]::abs($MoveY)

                if ((($MoveX -eq 1) -and ($MoveY -eq 2)) -or (($MoveX -eq 2) -and ($MoveY -eq 1))) {
                    $moveSuccess = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                } else {
                    Write-Error "Illegal Knight Move"
                }
            }

            'Bishop' {
                if ([math]::abs($MoveX) -ne [math]::abs($MoveY)) {
                    Write-Error "Illegal Bishop Move: Not a Diagonal"
                } else {
                    if ($MoveX -gt 0) {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Bishop Move: Blocked Path"
                                    Read-Input
                                    break
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Bishop Move: Blocked Path"
                                    Read-Input
                                    break
                                }
                            }
                        }
                    } else {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveY; $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Bishop Move: Blocked Path"
                                    Publish-Board
                                    break
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Bishop Move: Blocked Path"
                                    Publish-Board
                                    break
                                }
                            }
                        }
                    }
                    $moveSuccess = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                }
            }

            'Rook' {
                if (([math]::abs($MoveX) -gt 0) -and ([math]::abs($MoveY) -gt 0)) {
                    Write-Error "Illegal Rook Move"
                } else {
                    if ($MoveX -gt 0) {
                        for ($i = 1; $i -lt $MoveX; $i++) {
                            if ($board[($CurrentColumn + $i), $CurrentRow] -ne $Empty) {
                                    Write-Error "Illegal Rook Move: Blocked Path"
                                    Publish-Board
                                    break
                            }
                        }
                    } elseif ($MoveX -lt 0) {
                        for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                            if ($board[($CurrentColumn - $i), $CurrentRow] -ne $Empty) {
                                    Write-Error "Illegal Rook Move: Blocked Path"
                                    Publish-Board
                                    break
                            }
                        }
                    } elseif ($MoveY -gt 0) {
                        for ($i = 1; $i -lt $MoveY; $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Rook Move: Blocked Path"
                                    Publish-Board
                                    break
                            }
                        }
                    } else {
                        for ($i = 1; $i -lt [math]::abs($MoveY); $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Rook Move: Blocked Path"
                                    Publish-Board
                                    break
                            }
                        }
                    }
                    $moveSuccess = $true
                    $pc.firstmove = $false
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                }
            }

            'King' {
                $MoveX = [math]::abs($MoveX)
                $MoveY = [math]::abs($MoveY)

                if (($MoveX -eq 1) -or ($MoveY -eq 1)) {
                    $moveSuccess = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                } elseif (($pc.firstmove -eq $true) -and `
                        ($pc.color -eq 'White')) {
                    if (($dst -eq 'G1') -and `
                        ($wHR.firstmove -eq $true)) {
                        
                        $Crk = $board[7, 0]
                        $board[7, 0] = $Empty
                        $Crk.CurrentPosition = 'F1'
                        $Crk.CurrentRow = 0
                        $Crk.CurrentColumn = 5
                        $Crk.firstmove = $false

                        $moveSuccess = $true
                        $castle = [castleOptions]::kingside
                        $pc.firstmove = $false
                    } elseif (($dst -eq 'C1') -and `
                            ($wAR.firstmove -eq $true)) {
                        
                        $Crk = $board[0, 0]
                        $board[0, 0] = $Empty
                        $Crk.CurrentPosition = 'D1'
                        $Crk.CurrentRow = 0
                        $Crk.CurrentColumn = 3
                        $Crk.firstmove = $false

                        $moveSuccess = $true
                        $castle = [castleOptions]::queenside
                        $pc.firstmove = $false
                    }
                } elseif (($pc.firstmove -eq $true) -and `
                        ($pc.color -eq 'Black')) {
                    if (($dst -eq 'G8') -and `
                        ($bHR.firstmove -eq $true)) {
                        
                        $Crk = $board[7, 7]
                        $board[7, 7] = $Empty
                        $Crk.CurrentPosition = 'F8'
                        $Crk.CurrentRow = 7
                        $Crk.CurrentColumn = 5
                        $Crk.firstmove = $false

                        $moveSuccess = $true
                        $castle = [castleOptions]::kingside
                        $pc.firstmove = $false
                    } elseif (($dst -eq 'C8') -and `
                            ($bAR.firstmove -eq $true)) {
                        
                        $Crk = $board[0, 7]
                        $board[0, 7] = $Empty
                        $Crk.CurrentPosition = 'D8'
                        $Crk.CurrentRow = 7
                        $Crk.CurrentColumn = 3
                        $Crk.firstmove = $false

                        $moveSuccess = $true
                        $castle = [castleOptions]::queenside
                        $pc.firstmove = $false
                    }
                } else {
                    Write-Error "Illegal King Move"
                }
            }

            'Queen' {
                if ([math]::abs($MoveX) -eq [math]::abs($MoveY)) {
                    if ($MoveX -gt 0) {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                                }
                            }
                        }
                    } else {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveY; $i++) {
                                if ($board[($CurrentColumn - $i), ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                                }
                            }
                        }
                    }
                    $moveSuccess = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                } elseif (($MoveX -ne 0 -and $MoveY -eq 0) -or `
                        ($MoveX -eq 0 -and $MoveY -ne 0)) {
                    if ($MoveX -gt 0) {
                        for ($i = 1; $i -lt $MoveX; $i++) {
                            if ($board[($CurrentColumn + $i), $CurrentRow] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                            }
                        }
                    } elseif ($MoveX -lt 0) {
                        for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                            if ($board[($CurrentColumn - $i), $CurrentRow] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                            }
                        }
                    } elseif ($MoveY -gt 0) {
                        for ($i = 1; $i -lt $MoveY; $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow + $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                            }
                        }
                    } else {
                        for ($i = 1; $i -lt [math]::abs($MoveY); $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow - $i)] -ne $Empty) {
                                    Write-Error "Illegal Queen Move"
                                    Publish-Board
                                    break
                            }
                        }
                    }
                    $moveSuccess = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $attack = $true
                    }
                } else {
                    Write-Error "Illegal Queen Move"
                }
            }
        }

        if ($moveSuccess -eq $true) {
            if ($attack -eq $true -and $ep -eq $false) {
                $board[$DesiredColumn, $DesiredRow].Alive = $false
                $board[$DesiredColumn, $DesiredRow].CurrentPosition = $null
                $board[$DesiredColumn, $DesiredRow].CurrentRow = $null
                $board[$DesiredColumn, $DesiredRow].CurrentColumn = $null
            }

            #Pawn Promotion logic
            if (($pc.GetType().Name -eq 'Pawn') -and ($DesiredRow -eq 0)) {
                [ValidateSet('Knight', 'Bishop', 'Rook', 'Queen')]$ptype = Read-Host 'Promote black pawn to'
                
                $promote = $true
                $pc.Type = $ptype
                
                switch ($ptype) {
                    'Knight' {
                        $pc.Icon = '♞'
                        $pc.Symbol = 'N'
                    }
                    'Bishop' {
                        $pc.Icon = '♝'
                        $pc.Symbol = 'B'
                    }
                    'Rook' {
                        $pc.Icon = '♜'
                        $pc.Symbol = 'R'
                    }
                    'Queen' {
                        $pc.Icon = '♛'
                        $pc.Symbol = 'Q'
                    }
                }
            } elseif (($pc.GetType().Name -eq 'Pawn') -and ($DesiredRow -eq 7)) {
                [ValidateSet('Knight', 'Bishop', 'Rook', 'Queen')]$ptype = Read-Host 'Promote white pawn to'
                
                $promote = $true
                $pc.Type = $ptype

                switch ($ptype) {
                    'Knight' {
                        $pc.Icon = '♘'
                        $pc.Symbol = 'N'
                    }
                    'Bishop' {
                        $pc.Icon = '♗'
                        $pc.Symbol = 'B'
                    }
                    'Rook' {
                        $pc.Icon = '♖'
                        $pc.Symbol = 'R'
                    }
                    'Queen' {
                        $pc.Icon = '♕'
                        $pc.Symbol = 'Q'
                    }
                }
            }
            
            $board[$CurrentColumn, $CurrentRow] = $Empty
            $pc.CurrentPosition = $dst.ToUpper()
            $pc.CurrentRow = $DesiredRow
            $pc.CurrentColumn = $DesiredColumn

            Update-Board

            #Check logic
            #TODO: Shouldn't check when king is captured Issue 25
            Test-Gamestatus
            if ($Script:gameStatus -eq [gamestatus]::ongoing) {
                [Array]$curWhite = $Script:WhitePieces | Where-Object {$_.Alive -eq $true}
                [Array]$curBlack = $Script:BlackPieces | Where-Object {$_.Alive -eq $true}
    
                if ($Script:whiteTurn -eq $true) {
                    foreach ($whitePiece in $curWhite) {
                        if ($(Test-Move $whitePiece.CurrentPosition $Script:bK.CurrentPosition)[0] -eq $true) {
                            $check = $true
                        }
                    }
                } else {
                    foreach ($blackPiece in $curBlack) {
                        if ($(Test-Move $blackPiece.CurrentPosition $Script:wK.CurrentPosition)[0] -eq $true) {
                            $check = $true
                        }
                    }
                }
            }
            
            #Update the log, advance turn
            Update-Log $src $dst $pc.Symbol $attack $castle $promote $ep $check
            $Script:turnCounter += 1
            $Script:whiteTurn = !($Script:whiteTurn)
        } else {
            Read-Input
        }
    }
}

#Log logic will go here
function Update-Log {
    param([string]$src, [string]$dst, [string]$piece, [bool]$attack, 
          [int]$castle, [bool]$promote, [bool]$ep, [bool]$check, [bool]$resign)

    [string]$logentry = ''

    enum castleOptions {
        none = 0
        kingside = 1
        queenside = 2
    }

    if ($castle -eq [castleOptions]::kingside) {
        $logentry = '0-0'
    } elseif ($castle -eq [castleOptions]::queenside) {
        $logentry = '0-0-0'
    } elseif ($promote -eq $true) {
        if ($attack) {
            $logentry += 'x'
        }
        $logentry += $dst + '=' + $piece
    } else {
        $logentry = $piece
        if ($attack) {
            $logentry += 'x'
        }
        $logentry += $dst
    }

    if ($ep -eq $true) {
        $logentry += ' ep'
    }

    if ($check -eq $true) {
        $logentry += '+'
    }

    if ($Script:gameStatus -ne 0) {
        $logentry += '#'
    }

    if ($resign -eq $true) {
        $logentry = 'resigned'
    }

    $Script:log += $logentry
   
    #Equivalent of touch command to ensure a log exists
    Write-Output $null >> $Script:logpath

    #Clear and rewrite the log each time
    Clear-Content $Script:logpath
    $line = "White`t`tBlack`r`n--------------------"

    #Header
    Add-Content -Encoding Unicode $Script:logpath $line

    if ($log.Length -eq 1) {
        Add-Content -Encoding Unicode $Script:logpath $log[0]
    } else {
        for ($i = 0; $i -lt $log.Length - 1; $i += 2) {
            $line = $Script:log[$i]
            $line += " `t`t"
            $line += $Script:log[$i + 1]
            Add-Content -Encoding Unicode $Script:logpath $line
        }
        
        #If game ended in white move, print out the "half-line"
        if ($log.Length % 2 -eq 1) {
            Add-Content -Encoding Unicode $Script:logpath $Script:log[$Script:log.Length - 1]
        }
    } 
}

#Try a move, used for check and castling logic
function Test-Move {
    param ([string]$src, [string]$dst)

    [bool]$attack = $false
    [bool]$moveSuccess = $false
    [bool[]]$status = @($moveSuccess, $attack)

    try {
        [Int]$CurrentColumn = Get-Column $src[0]
        [Int]$CurrentRow = Get-Row $src[1]
        [Int]$DesiredColumn = Get-Column $dst[0]
        [Int]$DesiredRow = Get-Row $dst[1]

        $pc = $board[$CurrentColumn, $CurrentRow]
    } catch {
        Write-Error "Out of bounds"
        return $status
    }

    #Moving nothing, nowhere, or trying to capture your own piece
    if ($board[$CurrentColumn, $CurrentRow] -eq $Empty) {
        Write-Error "There is nothing there."
        return $status
    } elseif (($CurrentRow -eq $DesiredRow) -and ($CurrentColumn -eq $DesiredColumn)) {
        Write-Error "That wouldn't move anywhere."
        return $status
    } elseif ($board[$DesiredColumn, $DesiredRow] -ne $Empty -and `
              $pc.Color -eq $board[$DesiredColumn, $DesiredRow].Color) {
        Write-Error "Collision with own team"
        return $status
    } else {
        [int]$MoveX = $DesiredColumn - $CurrentColumn
        [int]$MoveY = $DesiredRow - $CurrentRow
        
        #Pieces playable
        switch ($pc.Type) {
            'Pawn' {
                $MoveX = [math]::abs($MoveX)
                if (($MoveX -gt 1) -or ([math]::abs($MoveY) -gt 2)) {
                    return $status
                } else {
                    #Force pawns to only move "forward"
                    if ($pc.Color -eq 'Black') {
                        $MoveY *= -1
                    }
                    if (($MoveX -eq 0) -and ($MoveY -eq 1)) {
                        if ($board[$DesiredColumn,$DesiredRow] -ne $Empty) {
                            return $status
                        } else {
                            $status[0] = $true
                            $pc.firstmove = $false
                        }
                    } elseif (($MoveX -eq 0) -and ($MoveY -eq 2)) {
                        if (($pc.firstmove = $true) -and `
                            (($board[$DesiredColumn, $DesiredRow] -eq $Empty) -and `
                            ($board[($DesiredColumn + 1), $DesiredRow] -eq $Empty))) {

                            $status[0] = $true
                            $pc.firstmove = $false
                            $pc.inpassing = $Script:turnCounter
                        } else {
                            return $status
                        }
                    } elseif (($MoveX -eq 1) -and ($MoveY -eq 1)) {
                        if ($board[$DesiredColumn,$DesiredRow] -eq $Empty) {
                            $enpassant = $board[$DesiredColumn, $CurrentRow]
                            if (($enpassant.GetType().Name -eq 'Pawn') -and `
                                ($pc.Color -ne $enpassant.Color) -and `
                                ($enpassant.inpassing -eq ($Script:turnCounter - 1))) {
                                
                                $status[0] = $true
                                
                                $enpassant.Alive = $false
                                $enpassant.CurrentPosition = $null
                                $enpassant.CurrentRow = $null
                                $enpassant.CurrentColumn = $null
                                $board[$DesiredColumn, $CurrentRow] = $Empty
                            } else {
                                return $status
                            }
                        } else {
                            $status[1] = $true
                            $status[0] = $true
                            $pc.firstmove = $false
                        }
                    } else {
                        return $status
                    }
                }
            }

            'Knight' {
                $MoveX = [math]::abs($MoveX)
                $MoveY = [math]::abs($MoveY)

                if ((($MoveX -eq 1) -and ($MoveY -eq 2)) -or (($MoveX -eq 2) -and ($MoveY -eq 1))) {
                    $status[0] = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                } else {
                    return $status
                }
            }

            'Bishop' {
                if ([math]::abs($MoveX) -ne [math]::abs($MoveY)) {
                    return $status
                } else {
                    if ($MoveX -gt 0) {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        }
                    } else {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveY; $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        }
                    }
                    $status[0] = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                }
            }

            'Rook' {
                if (([math]::abs($MoveX) -gt 0) -and ([math]::abs($MoveY) -gt 0)) {
                    return $status
                } else {
                    if ($MoveX -gt 0) {
                        for ($i = 1; $i -lt $MoveX; $i++) {
                            if ($board[($CurrentColumn + $i), $CurrentRow] -ne $Empty) {
                                return $status
                            }
                        }
                    } elseif ($MoveX -lt 0) {
                        for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                            if ($board[($CurrentColumn - $i), $CurrentRow] -ne $Empty) {
                                return $status
                            }
                        }
                    } elseif ($MoveY -gt 0) {
                        for ($i = 1; $i -lt $MoveY; $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow + $i)] -ne $Empty) {
                                return $status
                            }
                        }
                    } else {
                        for ($i = 1; $i -lt [math]::abs($MoveY); $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow - $i)] -ne $Empty) {
                                return $status
                            }
                        }
                    }
                    $status[0] = $true
                    $pc.firstmove = $false
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                }
            }

            'Queen' {
                if ([math]::abs($MoveX) -eq [math]::abs($MoveY)) {
                    if ($MoveX -gt 0) {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow + $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt $MoveX; $i++) {
                                if ($board[($CurrentColumn + $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        }
                    } else {
                        if ($MoveY -gt 0) {
                            for ($i = 1; $i -lt $MoveY; $i++) {
                                if ($board[($CurrentColumn - $i), ($CurrentRow + $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        } else {
                            for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                                if ($board[($CurrentColumn - $i) , ($CurrentRow - $i)] -ne $Empty) {
                                    return $status
                                }
                            }
                        }
                    }
                    $status[0] = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                } elseif (($MoveX -ne 0 -and $MoveY -eq 0) -or `
                        ($MoveX -eq 0 -and $MoveY -ne 0)) {
                    if ($MoveX -gt 0) {
                        for ($i = 1; $i -lt $MoveX; $i++) {
                            if ($board[($CurrentColumn + $i), $CurrentRow] -ne $Empty) {
                                    return $status
                            }
                        }
                    } elseif ($MoveX -lt 0) {
                        for ($i = 1; $i -lt [math]::abs($MoveX); $i++) {
                            if ($board[($CurrentColumn - $i), $CurrentRow] -ne $Empty) {
                                    return $status
                            }
                        }
                    } elseif ($MoveY -gt 0) {
                        for ($i = 1; $i -lt $MoveY; $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow + $i)] -ne $Empty) {
                                    return $status
                            }
                        }
                    } else {
                        for ($i = 1; $i -lt [math]::abs($MoveY); $i++) {
                            if ($board[$CurrentColumn, ($CurrentRow - $i)] -ne $Empty) {
                                    return $status
                            }
                        }
                    }
                    $status[0] = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                } else {
                    return $status
                }
            }

            'King' {
                $MoveX = [math]::abs($MoveX)
                $MoveY = [math]::abs($MoveY)

                if (($MoveX -le 1) -and ($MoveY -le 1)) {
                    $status[0] = $true
                    if ($board[$DesiredColumn, $DesiredRow] -ne $Empty) {
                        $status[1] = $true
                    }
                } elseif (($pc.firstmove -eq $true) -and `
                        ($pc.color -eq 'White')) {
                    if (($dst -eq 'G1') -and `
                        ($wHR.firstmove -eq $true)) {
                        
                        $Crk = $board[7, 0]
                        $board[7, 0] = $Empty
                        $Crk.CurrentPosition = 'F1'
                        $Crk.CurrentRow = 0
                        $Crk.CurrentColumn = 5
                        $Crk.firstmove = $false

                        $status[0] = $true
                        $pc.firstmove = $false
                    } elseif (($dst -eq 'C1') -and `
                            ($wAR.firstmove -eq $true)) {
                        
                        $Crk = $board[0, 0]
                        $board[0, 0] = $Empty
                        $Crk.CurrentPosition = 'D1'
                        $Crk.CurrentRow = 0
                        $Crk.CurrentColumn = 3
                        $Crk.firstmove = $false

                        $status[0] = $true
                        $pc.firstmove = $false
                    }
                } elseif (($pc.firstmove -eq $true) -and `
                        ($pc.color -eq 'Black')) {
                    if (($dst -eq 'G8') -and `
                        ($bHR.firstmove -eq $true)) {
                        
                        $Crk = $board[7, 7]
                        $board[7, 7] = $Empty
                        $Crk.CurrentPosition = 'F8'
                        $Crk.CurrentRow = 7
                        $Crk.CurrentColumn = 5
                        $Crk.firstmove = $false

                        $status[0] = $true
                        $pc.firstmove = $false
                    } elseif (($dst -eq 'C8') -and `
                            ($bAR.firstmove -eq $true)) {
                        
                        $Crk = $board[0, 7]
                        $board[0, 7] = $Empty
                        $Crk.CurrentPosition = 'D8'
                        $Crk.CurrentRow = 7
                        $Crk.CurrentColumn = 3
                        $Crk.firstmove = $false

                        $status[0] = $true
                        $pc.firstmove = $false
                    }
                } else {
                    return $status
                }
            }
        }

        return $status
    }
}

#Figure out if the game is over or still ongoing
function Test-Gamestatus {
    if ($wK.Alive -eq $false) {
        $Script:gameStatus = [gamestatus]::blackWin
    } elseif ($bK.Alive -eq $false) {
        $Script:gameStatus = [gamestatus]::whiteWin
    }
}

function Get-Column {
    param ([ValidatePattern('[A-H]')][string]$Col)
    switch ($Col) {
        "A" {Return "0"}
        "B" {Return "1"}
        "C" {Return "2"}
        "D" {Return "3"}
        "E" {Return "4"}
        "F" {Return "5"}
        "G" {Return "6"}
        "H" {Return "7"}
    }
}

function Get-Row {
    param ([ValidateRange(1,8)][string]$row)

    return ($row - 1)
}

###########################
#endregion: Functions
####################################################


####################################################
#region: Classes
###########################

#Gives all classes that inherit(:) this class the base properties
Class ChessPiece {
    [bool]$Alive=$true
    [string]$Type
    [string]$Icon
    [string]$Symbol
    [ValidateSet('White', 'Black')][String]$Color
    [String]$CurrentPosition
    [ValidateRange(0,7)][Int]$CurrentRow
    [ValidateRange(0,7)][Int]$CurrentColumn
}

Class Pawn : ChessPiece {
    [bool]$firstmove = $true
    [int]$inpassing = 0
    [string]$Type = $this.GetType().Name
    [string]$Symbol = " "
    Pawn([string]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♙'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♟'
        }
    }
}

Class Rook : ChessPiece {
    [bool]$firstmove = $true
    [string]$Type = $this.GetType().Name
    [string]$Symbol = "R"
    Rook([string]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♖'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♜'
        }
    }
}

Class Knight : ChessPiece {
    [string]$Type = $this.GetType().Name
    [string]$Symbol = "N"
    Knight([string]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♘'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♞'
        }
    }
}

Class Bishop : ChessPiece {
    [string]$Type = $this.GetType().Name
    [string]$Symbol = "B"
    Bishop([String]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♗'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♝'
        }
    }
}

Class Queen : ChessPiece {
    [string]$Type = $this.GetType().Name
    [string]$Symbol = "Q"
    Queen([String]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♕'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♛'
        }
    }
}

Class King : ChessPiece {
    [bool]$firstmove = $true
    [string]$Type = $this.GetType().Name
    [string]$Symbol = "K"
    King([String]$Position, [string]$color) {
        $this.Color = $color
        $this.CurrentPosition = $Position
        $this.CurrentRow = Get-Row $Position[1] 
        $this.CurrentColumn = Get-Column $Position[0]

        if ($color -eq 'White') {
            $this.Icon = '♔'
        } elseif ($color -eq 'Black') {
            $this.Icon = '♚'
        }
    }
}

Class Blank {
    [String]$Icon=' '
}

###########################
#endregion: Classes
####################################################

#Creates the game board
[Object]$Script:board = New-Object 'object[,]' 8,8

#Creates a turn status
[bool]$Script:whiteTurn = $true

#SAN log.txt path, currently on desktop
$DesktopPath = [Environment]::GetFolderPath("Desktop")
[string]$Script:logpath = $DesktopPath + '\log.txt'
[string[]]$Script:log = @()

$Script:wAP = [Pawn]::New('A2', 'White')
$Script:wBP = [Pawn]::New('B2', 'White')
$Script:wCP = [Pawn]::New('C2', 'White')
$Script:wDP = [Pawn]::New('D2', 'White')
$Script:wEP = [Pawn]::New('E2', 'White')
$Script:wFP = [Pawn]::New('F2', 'White')
$Script:wGP = [Pawn]::New('G2', 'White')
$Script:wHP = [Pawn]::New('H2', 'White')
$Script:wAR = [Rook]::New('A1', 'White')
$Script:wBN = [Knight]::New('B1', 'White')
$Script:wCB = [Bishop]::New('C1', 'White')
$Script:wQ  = [Queen]::New('D1', 'White')
$Script:wK  = [King]::New('E1', 'White')
$Script:wFB = [Bishop]::New('F1', 'White')
$Script:wGN = [Knight]::New('G1', 'White')
$Script:wHR = [Rook]::New('H1', 'White')

$Script:bAP = [Pawn]::New('A7', 'Black')
$Script:bBP = [Pawn]::New('B7', 'Black')
$Script:bCP = [Pawn]::New('C7', 'Black')
$Script:bDP = [Pawn]::New('D7', 'Black')
$Script:bEP = [Pawn]::New('E7', 'Black')
$Script:bFP = [Pawn]::New('F7', 'Black')
$Script:bGP = [Pawn]::New('G7', 'Black')
$Script:bHP = [Pawn]::New('H7', 'Black')
$Script:bAR = [Rook]::New('A8', 'Black')
$Script:bBN = [Knight]::New('B8', 'Black')
$Script:bCB = [Bishop]::New('C8', 'Black')
$Script:bQ  = [Queen]::New('D8', 'Black')
$Script:bK  = [King]::New('E8', 'Black')
$Script:bFB = [Bishop]::New('F8', 'Black')
$Script:bGN = [Knight]::New('G8', 'Black')
$Script:bHR = [Rook]::New('H8', 'Black')

$Script:Empty = [Blank]::New()

[Array] $Script:WhitePieces = @(
    $Script:wAP,$Script:wBP,$Script:wCP,$Script:wDP,
    $Script:wEP,$Script:wFP,$Script:wGP,$Script:wHP,
    $Script:wAR,$Script:wHR,$Script:wBN,$Script:wGN,
    $Script:wCB,$Script:wFB,$Script:wQ,$Script:wK
)

[Array] $Script:BlackPieces = @(
    $Script:bAP,$Script:bBP,$Script:bCP,$Script:bDP,
    $Script:bEP,$Script:bFP,$Script:bGP,$Script:bHP,
    $Script:bAR,$Script:bHR,$Script:bBN,$Script:bGN,
    $Script:bCB,$Script:bFB,$Script:bQ,$Script:bK
)

enum gamestatus {
    ongoing = 0
    whiteWin = 1
    blackWin = 2
    quit = 3
}

#Set global variables to keep track of turn and game status
[int]$Script:turnCounter = 0
$Script:gameStatus = [gamestatus]::ongoing

while ($Script:gameStatus -eq [gamestatus]::ongoing) {
    Update-Board
    Publish-Board
    Read-Input

    if ($Script:gameStatus -eq [gamestatus]::blackWin) {
        Write-Output "Black Wins!"
    } elseif ($Script:gameStatus -eq [gamestatus]::whiteWin) {
        Write-Output "White Wins!"
    } elseif ($Script:gameStatus -eq [gamestatus]::quit) {
        Write-Output "Game ended by request."
    }
}
