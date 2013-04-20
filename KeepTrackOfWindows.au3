Global $Begin = 1, $ActiveTime = '', $TrapTitle = '', $DeActiveTime = ''
HotKeySet('{l}', 'EXITTRACK')
AdlibRegister('KeepTrackOfWindows', 250)

While 1
    Sleep(1000)
WEnd

Func KeepTrackOfWindows()
    Local $w_WinList = WinList()
    For $i = 1 to $w_WinList[0][0]
        If $w_WinList[$i][0] <> "" AND BitAnd(WinGetState($w_WinList[$i][1]), 10) Then 
            $ActiveWindow = $w_WinList[$i][0]
            ExitLoop
        EndIf
    Next
    If $Begin = 1 Then
        $TrapTitle = $ActiveWindow
		;ConsoleWrite($TrapTitle)
        $ActiveTime = @MDAY & '-' & @MON & '-' & @YEAR _ 
        & '@' & @HOUR & ':' & @MIN & ':' & @SEC & ';'
        $Begin = 2
    ElseIf $TrapTitle <> $ActiveWindow And $TrapTitle <> '' Then
        $DeActiveTime = @MDAY & '-' & @MON & '-' & @YEAR _ 
        & '@' & @HOUR & ':' & @MIN & ':' & @SEC & ';' & $TrapTitle
        FileWrite(@DesktopDir & '\testing.txt', $ActiveTime & $DeActiveTime & @CRLF)
        $TrapTitle = ''
        $Begin = 1
    EndIf
EndFuncl

Func EXITTRACK()
    Exit
EndFunc