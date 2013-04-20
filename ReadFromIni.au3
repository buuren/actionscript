#include <file.au3>
#include <GUIConstants.au3>

if FileExists(@scriptDir & "/config.ini") Then 
	  $yes = MsgBox(4, "File exists", "File exists. Do you want to use it?")
	  If $yes = 6 Then
		 ;MsgBox(0, "Done", "Using init file...")
		 Local $sServerIP = IniRead(@ScriptDir & "\config.ini","config", "sServerIP" , "Error. Not found")
		 Local $sDatabase = IniRead(@ScriptDir & "\config.ini","config", "sDatabase" , "Error. Not found")
		 Local $sUsername = IniRead(@ScriptDir & "\config.ini","config", "sUsername" , "Error. Not found")
		 $yes1 = MsgBox(4, "Information", "Server IP address: " & $sServerIP & @CRLF & "Database name: " & $sDatabase & @CRLF & "Database username: " & $sUsername & @CRLF & @CRLF & "Use that data?")
			if $yes1 = 6 Then
			   FileClose(@ScriptDir & "\config.ini")
			   MsgBox(0, "Data used", "Connecting to database...", 2)
			else 
			   MsgBox(0, "Not used", "Script ends", 2)
			   Exit
			endif   
	  else 
		 MsgBox(0, "Ok", "File wans't used. Script ends", 2)
	  endif

Else 
	  $yes2 = MsgBox(4, "File does not exist", "File does not exist. Location should be: " & @Scriptdir &  "\" & @CRLF & "Do you want to create it?")
	  If $yes2 = 6 Then
		 $file = _FileCreate ( @ScriptDir & '\' & 'config.ini' )
		 $writeIP = InputBox("Input box","Server IP address")
		 $writeDBname = InputBox("Input box","Database name")
		 $writeDBuser = InputBox("Input box","Database user")
		 $writeDBpass = InputBox("Input box","User password", 0)
		 FileWrite( @ScriptDir & "\config.ini", "[config]" & @CRLF & "sServerIP = " & '"' & $writeIP & '"' & @CRLF & "sDatabase = " & '"' & $writeDBname & '"'& @CRLF & "sUsername = " & '"' & $writeDBuser & '"')
		 $yes3 = MsgBox(4, "Information", "Server IP address: " & $writeIP & @CRLF & "Database name: " & $writeDBname & @CRLF & "Database username: " & $writeDBuser & @CRLF & "User password: " & $writeDBpass & @CRLF & @CRLF & "Use that data?")
			if $yes3 = 6 Then
			   Global $MySQLConn = ObjCreate("ADODB.Connection")
			   $MySQLConn.Open("DRIVER={MySQL ODBC 5.1 Driver};SERVER=" & $writeIP & ";DATABASE=" & $writeDBname & ";UID=" & $writeDBuser & ";PWD=" & $writeDBpass & ";PORT=3306")
			   MsgBox(0, "Data used", "Connecting to database...", 1)
			
			   $MySQLConn.Close
			   FileClose(@ScriptDir & "\config.ini")
			   FileDelete(@ScriptDir & "\config.ini")
			else 
			   MsgBox(0, "Not used", "Script ends. Deleting config", 2)
			   FileClose(@ScriptDir & "\config.ini")
			   FileDelete(@ScriptDir & "\config.ini")
			   Exit
			endif
	  else 
		 MsgBox(0, "Ok", "End", 1)
	  endif
endif