#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
main()
Func main()
   Global $hGui = GUICreate("Life-Time-USB 03036008080", 660, 500)
Global $hTab = GUICtrlCreateTab(7, 60, 640, 380)
GUICtrlCreateTabItem("Main Menu")
	; Set folder path to read icon files from
Local $folderPath = "C:\Users\Muhammad\Desktop\proj\FinaIicons"
; Get all icon files in the folder and remove extension
Local $exesName_A = _FileListToArray($folderPath, "*.ico", 1)
For $i = 1 To $exesName_A[0]
    $exesName_A[$i] = StringRegExpReplace($exesName_A[$i], "\.ico$", "")
Next

If $exesName_A[0] = 753 Then


Local $sBatchFileContent = '@echo off' & @CRLF & _
                          'setlocal' & @CRLF & _
                          'set pas=%1' & @CRLF & _
                          'set exe=%2' & @CRLF & _
                          '"'&@ScriptDir&'\tools\7z.exe" x '&@ScriptDir&'UTZ.7z -o%temp%\UTZTemp "%exe%" -r- -p%pas%' & @CRLF & _
                          'if errorlevel 1 (' & @CRLF & _
                          '    echo Extraction failed!' & @CRLF & _
                          ') else (' & @CRLF & _
                          '    "%temp%\UTZTemp\%exe%"' & @CRLF & _
                          ')'

Local $sBatchFilePath = @TempDir & "\UTZTemp\extract_UTZ.bat"

If Not FileExists(@TempDir & "\UTZTemp") Then DirCreate(@TempDir & "\UTZTemp")

Local $hBatchFile = FileOpen($sBatchFilePath, $FO_OVERWRITE)
If $hBatchFile = -1 Then
    MsgBox($MB_OK + $MB_ICONERROR, "Error", "Failed to create nesessory files.")
Else
    FileWrite($hBatchFile, $sBatchFileContent)
    FileClose($hBatchFile)
    MsgBox($MB_OK, "Success", "Menu is Ready For Using" & @CRLF )
EndIf


Local $height = 40, $width = 125, $y = 0, $x = 0,  $z = 1
    Global $button_A[UBound($exesName_A)]
For $i = 1 To UBound($exesName_A) - 1
    If ((8 + ($x + 1) * $width) > 635) Then
        $y += 1
        $x = 0
    EndIf
    If ($y = 10) Then
        $hTab = GUICtrlCreateTabItem("Sub-Menu-" & $z)
        $y = 0
        $z += 1
    EndIf
        $button_A[$i] = GUICtrlCreateButton(''&$exesName_A[$i], 10 + ($x * 2) + $x * $width, ($y * 2) + 80 + $y * $height, $width, $height,$BS_left)
		GUICtrlSetImage(-1, $folderPath & '\' &$exesName_A[$i]&'.ico', '', 2)
		$x += 1
    Next
    GUISetState(@SW_SHOW)
    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                Exit
        EndSwitch
        ; scan all buttons to check if one was pressed
	For $i = 0 To UBound($button_A) - 1
		If $nMsg = $button_A[$i] Then

; Call the batch script using the Run function
Run(@ComSpec & ' /c '&$hBatchFile&' Utz8080Utz2023toEnd ' &$exesName_A[$i]&'.exe', "", @SW_HIDE)

			EndIf

	Next
	DirRemove(@TempDir & "\UTZTemp",1)
	WEnd



Else
	MsgBox($MB_OK, "Items Error", "Contact the vender 03036008080")
EndIf
EndFunc   ;==>main
