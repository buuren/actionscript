;--------------------------------------------------------------------------------
;----------------------------- READ Computer name 1 -----------------------------
RunWait(@ComSpec & " /c " & 'echo %COMPUTERNAME% > C:\Temp.txt', "", @SW_HIDE)
$file = FileOpen("C:\temp.txt", 0)
$read = FileRead($file)
If @error = -1 Then
    MsgBox(0, "Error", "File not read")
    Exit
Else
   If StringRegExp($read, "REKLAAM") Then
	  MsgBox(0, "Oops", "Works " & $read)
   Else
	  MsgBox(0, "At all", "at all")
   EndIf
EndIf
FileClose($file)
FileDelete("C:\Temp.txt")
;--------------------------------------------------------------------------------







;--------------------------------------------------------------------------------
;----------------------------- READ Computer name 2 -----------------------------
#include <Constants.au3>

Global $DOS, $Message = '' ;; added "= ''" for show only.

$DOS = Run(@ComSpec & ' /c net config workstation | find "Workstation domain" ', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
ProcessWaitClose($DOS)
$Message = StdoutRead($DOS)

If StringRegExp($message, "Off") Then
   MsgBox(0, "Oops", "works")
Else
   MsgBox(0, "At all", "bugged")
EndIf
;--------------------------------------------------------------------------------









;--------------------------------------------------------------------------------
;----------------------------- Read from IP address -----------------------------
$SPLIT = StringSplit(@IPAddress1,".")

if IsArray($SPLIT) Then
   If $SPLIT[1] = "192"and $SPLIT[2] = "168" and $SPLIT[3] = "60" and $SPLIT[4] = "161" Then
	  MsgBox(262144+4+4096,"Hello!","Привет! Это Вова!!!))")
   else
   endIf
else
endIf
;--------------------------------------------------------------------------------