Opt("WinTitleMatchMode", 2)
HotKeySet("{ESC}", "leave")
$title = ''
$url = ''
While 1
   Sleep(100)
   $title2 = WinGetTitle("")
   If StringInStr($title2, "Internet Explorer") OR StringInStr($title2, "Firefox") Then
      $text = WinGetText($title2)
	  ConsoleWrite($text)
	  ;$aResult = WinGetText($text, "")
	  ;ConsoleWrite($aResult)
	  ;$aResult = StringRegExp ($text, "(?:\s*)?(.+)(?:\n)?", 2)
	  $file = FileOpen("\\ubuntu64\sys$\scripts\temp.txt", 1)
      FileWrite($file, $text)
      FileClose($file)
      $url2 = FileReadLine("\\ubuntu64\sys$\scripts\temp.txt", 2)
      FileDelete("\\ubuntu64\sys$\scripts\temp.txt")
      
      If $url <> $url2 And $url2 <> '' Then
         $url = $url2
         $title = $title2
         
         $file = FileOpen("\\ubuntu64\sys$\scripts\ielog.txt", 1); write URL in log in log file together with Window Title
         FileWriteLine($file, @MDAY & "/" & @MON & "/" & @YEAR & " " & @HOUR & ":" & @MIN & ":" & @SEC & " URL: " & $url  & " Title: " & $title )
         FileClose($file)
      EndIf
   EndIf
WEnd

Func leave()
    Exit
EndFunc