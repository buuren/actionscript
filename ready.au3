#Region Includes
#Include <Array.au3>
#include <date.au3>
#include <Constants.au3>
#EndRegion Includes
#NoTrayIcon

Global $oMySQLError = ObjEvent("AutoIt.Error", "_MySQLError") ; переменная для чтение ошибок

; Dim $sDBServerIP = IniRead("C:\Documents and Settings\Hahaha\Desktop\scripts\read.ini","config", "sDBServerIP" ,"Default")

Dim $sDBServerIP = "192.168.60.134"			; IP адресс севера с MySQL
Dim $sDBUsername = "estellog"        		; Имя пользователя для подключения к базе данных
Dim $sDBPassword = "asdaoopqwe"				; Пароль
Dim $sDatabase   = "estelstatistic"       	; База Данных к которой будем подключаемся
Dim $sTableName = "data" 					; Общая таблица куда кидаем данные
$pc_name = @ComputerName 					; Имя комьютера
$user_name = @UserName 						; Имя пользователя
$time = _NowTime(5) 						; Время на комьютере
$IP = @IPAddress1							; ИП адресс комьютера
$console = @AppDataCommonDir				; ConsoleWrite("PC name: " & $pc_name & " Username: " & $user_name & " Time is: " & $time & @CRLF)

;------------- Метод подсчёта время работы -------------
$aTSB = DllCall ("kernel32.dll", "long", "GetTickCount")
$ticksSinceBoot = $aTSB[0]

dim $iHours, $iMins, $iSecs
_TicksToTime ( $ticksSinceBoot, $iHours, $iMins, $iSecs)
$iDays = int($iHours / 24)
$iHours = $iHours - ($iDays * 24)
;-------------------------------------------------------


;Global $DOS, $Message = '' ;; added "= ''" for show only.

$DOS = Run(@ComSpec & ' /c net config workstation | find "Workstation domain" ', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($DOS)
$Message = StdoutRead($DOS)

If StringRegExp($message, "MARKETasdING") Then
   MsgBox(0, "Works", "Test")
Else
   
EndIf

If $IP = "192.168.60.161" Then
   MsgBox(0, "works", "Test")
Else
Endif

; Подключаемся к Серверу
Global $MySQLConn = ObjCreate("ADODB.Connection")
$MySQLConn.Open("DRIVER={MySQL ODBC 5.1 Driver};SERVER=" & $sDBServerIP & ";DATABASE=" & $sDatabase & ";UID=" & $sDBUsername & ";PWD=" & $sDBPassword & ";PORT=3306")

; Запуск скрипта происходит через ключи. Если ключ не указан, программа ничего не делает
If $cmdLine[0] > 0 Then

; Пишем данные с action = schedule. Дописываем ключ /schedule к .exe файлу
If $cmdline[1] = "/schedule" then
   ;Local $command = IniRead(@ScriptDir & "\config.ini","config", "command" , "Error. Not found")
   ;Dim $sInsertQuery = IniRead(@ScriptDir & "\config.ini","config", "bazasql" , "Error. Not found")
  ; $MySQLConn.Execute($sInsertQuery)
   Run("notepad")

; Пишем данные с action = logoff. Дописываем ключ /logoff к .exe файлу
ElseIf $cmdline[1] = "/logoff" 		then
Dim $sInsertQuery = "INSERT INTO `data` (PC_name, user_name, IP_address, time, uptime_days, uptime_hours, uptime_minutes, uptime_seconds, action) VALUES ('" & $pc_name & "','" & $user_name & "','" & $IP & "','" & $time & "','" & $iDays & "','" & $iHours & "','" & $iMins & "','" & $iSecs & "', 'LOGOFF');"
$MySQLConn.Execute($sInsertQuery)

; Пишем данные c action = logout. Дописываем ключ /login к .exe файлу
ElseIf $cmdline[1] = "/login"	 	then
Dim $sInsertQuery = "INSERT INTO `data` (PC_name, user_name, IP_address, time, uptime_days, uptime_hours, uptime_minutes, uptime_seconds, action) VALUES ('" & $pc_name & "','" & $user_name & "','" & $IP & "','" & $time & "','" & $iDays & "','" & $iHours & "','" & $iMins & "','" & $iSecs & "', 'LOGIN');"
$MySQLConn.Execute($sInsertQuery)

; Пишем данные c action = startup. Дописываем ключ /startup к .exe файлу
ElseIf $cmdline[1] = "/startup" 	then
Dim $sInsertQuery = "INSERT INTO `data` (PC_name, user_name, IP_address, time, uptime_days, uptime_hours, uptime_minutes, uptime_seconds, action) VALUES ('" & $pc_name & "','" & $user_name & "','" & $IP & "','" & $time & "','" & $iDays & "','" & $iHours & "','" & $iMins & "','" & $iSecs & "', 'STARTUP');"
$MySQLConn.Execute($sInsertQuery)

; Пишем данные c action = shutdown. Дописываем ключ /shutdown к .exe файлу
ElseIf $cmdline[1] = "/shutdown"	then
Dim $sInsertQuery = "INSERT INTO `data` (PC_name, user_name, IP_address, time, uptime_days, uptime_hours, uptime_minutes, uptime_seconds, action) VALUES ('" & $pc_name & "','" & $user_name & "','" & $IP & "','" & $time & "','" & $iDays & "','" & $iHours & "','" & $iMins & "','" & $iSecs & "', 'SHUTDOWN');"
$MySQLConn.Execute($sInsertQuery)

;ElseIf $cmdline[1] = "/work"	then
;Dim $work = RunWait(@ComSpec & ' /c netsh firewall add allowedprogram "' & @ScriptFullPath & '" "' & @ScriptName & '" ENABLE',"",@SW_HIDE)
;Run($work)

; END IF 1
EndIf

; END IF 0
EndIf

; Отключаемся от сервера
$MySQLConn.Close

; Функция для чтения ошибок
Func _MySQLError()
    $HexNumber = Hex($oMySQLError.number, 8)

    MsgBox(16, "MySQL Error", "err.description is  : " & @TAB & $oMySQLError.description & @CRLF & _
                                                        "err.windescription  : " & @TAB & $oMySQLError.windescription & @CRLF & _
                                                        "err.number is       : " & @TAB & $HexNumber & @CRLF & _
                                                        "err.lastdllerror is : " & @TAB & $oMySQLError.lastdllerror & @CRLF & _
                                                        "err.scriptline is   : " & @TAB & $oMySQLError.scriptline & @CRLF & _
                                                        "err.source is       : " & @TAB & $oMySQLError.source & @CRLF & _
                                                        "err.helpfile is     : " & @TAB & $oMySQLError.helpfile & @CRLF & _
                                                        "err.helpcontext is  : " & @TAB & $oMySQLError.helpcontext)

    Exit

    SetError(1)  ; to check for after this function returns
EndFunc