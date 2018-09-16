#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Alfredo Vecino

 Script Function:
	Updates Google Domains Dynamic DNS synthetic record

#ce ----------------------------------------------------------------------------

#include <Inet.au3>
#include <File.au3>

Local $appName = "GD Updater"
Local $version = "1.0"

Local $configFile = "config.ini"
Local $iniSection = "Global"
Local $logFile = "gd"

_Log("Starting application.. v"&$version)

Local $username = IniRead($configFile,$iniSection,"username",Null)
Local $password = IniRead($configFile,$iniSection,"password",Null)
Local $hostname = IniRead($configFile,$iniSection,"hostname",Null)
Local $myip = IniRead($configFile,$iniSection,"myip",Null)
Local $interval = IniRead($configFile,$iniSection,"interval",Null)

If $username == Null Or $password == Null Or $hostname == Null Or $interval == Null Then
	MsgBox(0,"Error","One or more fields in "&$configFile&" are missing. Exiting..")
	_Log("One or more fields in "&$configFile&" are missing")
	_Exit(@ScriptLineNumber)
EndIf

While 1
	Local $publicIp = _GetIP()
	Local $url = "https://" & $username & ":" & $password & "@domains.google.com/nic/update?hostname=" & $hostname & "&myip=" & $publicIp

	If $publicIp == $myip Then
		_Log("IP hasn't changed")
	Else
		$response = _SendRequest($url)
		If $response <> -1 Then
			$myip = $publicIp
			IniWrite($configFile,$iniSection,"myip",$publicIp)
			_Log("Updated myip with: "&$myip)
		EndIf
	EndIf

	Sleep($interval * 60 * 1000)
WEnd



Func _SendRequest($url)
	Local $rawData, $response

	_Log("Sending Request..")
	$rawData = InetRead($url)
	If @error Then
		_Log(@error,1)
		Return -1
	EndIf

	$response = BinaryToString($rawData)
	_Log("Server Response: "&$response)

	Return $response
EndFunc

;Log Function / 0 = INFO, 1 = ERROR, 2 = DEBUG
Func _Log($message,$flag = 0)
	Local $flags = ["INFO","ERROR","DEBUG"]
	Local $date = @MDAY&"-"&@MON&"-"&@YEAR
	_FileWriteLog(@ScriptDir & "\" & $logFile & "-" & $date & ".log", "@" & $flags[$flag] & " - " & $message)
EndFunc

Func _Exit($code=0)
	_Log("Exiting application.. code:"&$code)
	Exit
EndFunc
