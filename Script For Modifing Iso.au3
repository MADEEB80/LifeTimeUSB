	; chose any windows iso
$message = "choose Any Windows Iso"
; for getting file-path
Local $filepath = FileOpenDialog($message, @ScriptDir & "\", "Standard ISO Images (*.iso)", 1 )
; for getting file-name
Local $filename = StringRegExpReplace($filepath, "^.*\\", "")
; for getting file-name without extension
Local $filenamewithoutext = StringRegExpReplace($filepath, "^.*\\|\..*$", "")
Local $fullfilePath = StringRegExpReplace($filepath, "(^.*\\)(.*)", "\1")
Local $Sr1 = StringRegExpReplace($filepath, ":.*$", "")
Local $Dir1 = (@ScriptDir&"\Temp_UTZ")
Local $Dir2 = (@ScriptDir&"\Temp_UTZ\Windows")
Local $Dir3 = (@ScriptDir&"\Temp_UTZ\Windows\System32")
Local $Sr2 = ($Sr1&":\WINSETUP")
Local $Sr3 = ($Sr2&"\"&$filenamewithoutext)

; for checking error
If @error Then
    MsgBox(4096,"","No Valid File(s) chosen")
; these are some steps
Else
    $filepathmsg = MsgBox("Path","Here is File Path", $filepath)
	$fileNamemsg = MsgBox("Path","Here is File Path", $FileName)
;	$DST = FileSelectFolder("Please Select LifeTimeUSB DESTINATION","") ;user prompt to select a destination

	; Remove custom Temp if already exist
	$sfile = DirRemove ( $Dir1 , 1 )
	; for define custom Temp
	DirCreate($Dir3)

	; Extract boot.wim File from windows iso
	RunWait('"'&@ScriptDir & '\Tools\7zip\7z.exe"' & ' e "' & $filepath & '" ' & "-o" & '"' & $Dir1 & '" sources\boot.wim', "", @SW_HIDE)
	MsgBox(4096,"","7zip work done")
	; Write a Winpeshl.ini

	FileWrite($Dir3 & "\Winpeshl.ini","")
	$file = FileOpen($Dir3&"\Winpeshl.ini", 9)
	FileWrite($file, "[LaunchApps]" & @CRLF)
	FileWrite($file, '%systemdrive%\windows\WinPreSetup.exe, "/mountiso=WINSETUP\'&$filenamewithoutext&'\' & $filename & @CRLF)
	FileWrite($file, '%systemdrive%\windows\WinPreSetup.exe, "/startsetup"')
	FileClose($file)
	MsgBox(4096,"","Winpeshl.ini created")
	; copy a file to custom temp for using in next step
	FileCopy (@ScriptDir&"\Tools\WinPreSetup.exe" , $Dir2 ,9 )
	MsgBox(4096,"","WinPreSetup.exe copied")
	FileSetAttrib ( $Dir1, "-RSH" , 1 )

	Run wimlib command for adding some files
	$CMD = @ScriptDir & '\Tools\wimlib\wimlib-imagex.exe update Temp_UTZ\boot.wim 2 --command="add Temp_UTZ\Windows \Windows"'
	Run(@ComSpec & " /k " & $CMD)


;  if need then Run wimlib command manualy for adding some files
	MsgBox(4096,"","Please Run Wimlib Batch File then click Ok")

	MsgBox(4096,"","Wimlib work done")
	; Now removing Windows dir from custom temp
	DirRemove ($Dir2,1)
	; Move modified boot.wim into root with new name

	DirCreate($Sr3)

	MsgBox(4096,"","Create sr3")
	FileSetAttrib ( $Sr2, "+RSH" , 1 )
	DirCopy (@ScriptDir&"\Tools\imdisk" , $Sr2&"\imdisk" ,1 )
	FileMove ($filepath , $Sr3&"\"&$filenamewithoutext&".iso" , 1 )
	FileMove ( $Dir1 & "\boot.wim", $fullfilePath&$filenamewithoutext&".wim" , 1 )
	;Remove Custom temp
	DirRemove ($Dir1,1)
	MsgBox(4096,"","All work done")
EndIf
