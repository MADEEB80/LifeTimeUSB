#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
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
Local $height = 40, $width = 125, $y = 0, $x = 0,  $z = 1
    Global $button_A[UBound($exesName_A)]
For $i = 0 To UBound($exesName_A) - 1
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
		GUICtrlSetImage(-1, $folderPath & '\' & StringRegExpReplace($exesName_A[$i], '\.ico$', '') & '.ico', '', 2)
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
			RunWait(@ComSpec & ' /c "'&@ScriptDir&'\Tools\7zip\7z.exe" x "UTZ.7z" "' & $exesName_A[$i] & '.exe" -p123 -o"%temp%\UTZtemp"', @ScriptDir, '', @SW_HIDE)
			ShellExecuteWait(@TempDir&'\UTZTemp\'& $exesName_A[$i] & @CRLF)
				   EndIf
        Next
    WEnd
EndFunc   ;==>main
