#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <_7Zip.au3>

Global Const $folderPath = "C:\Users\Muhammad\Desktop\proj\FinaIicons"
Global $exesName_A = _FileListToArray($folderPath, "*.ico", 1)

For $i = 1 To $exesName_A[0]
    $exesName_A[$i] = StringRegExpReplace($exesName_A[$i], ".ico$", "")
Next

Global Const $SS_LEFT = 0x00000000
Global Const $SS_CENTERIMAGE = 0x00000200
Global Const $SS_CENTER = 0x00000001
Global $height = 100, $width = 100, $y = 0, $x = 0, $z = 1
Global $hGui = GUICreate("Main Menu", 960, 720)
Global $hTab = GUICtrlCreateTab(10, 60, 940, 637)
GUICtrlCreateTabItem("Main Menu")

Global $button_A[UBound($exesName_A)]

For $i = 0 To UBound($exesName_A) - 1
    If ((4 + ($x + 1) * $width) > 940) Then
        $y += 1
        $x = 0
    EndIf

    If ($y = 4) Then
        $hTab = GUICtrlCreateTabItem("Sub-Menu-" & $z)
        $y = 0
        $z += 1
    EndIf

    $button_A[$i] = GUICtrlCreateButton('', 8 + ($x * 5) + $x * $width, ($y * 20) + 80 + $y * $height, $width, $height, $BS_ICON)
    GUICtrlSetImage(-1, $folderPath & '\' & $exesName_A[$i] & '.ico', '', 4)
    $labelWidth = StringLen($exesName_A[$i]) * 5
    $style = ($labelWidth >= $width) ? BitOR($SS_LEFT, $SS_CENTERIMAGE) : $SS_CENTER
    GUICtrlCreateLabel($exesName_A[$i], 8 + ($x * 5) + $x * $width, ($y * 20) + 80 + $y * $height + 100, $width, 15, $style)

    $x += 1
Next

GUISetState(@SW_SHOW)

While True
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_PRIMARYDOWN
            Local $nMsg = GUICtrlRead(@GUI_CtrlId)
            For $i = 0 To UBound($button_A) - 1
                If $nMsg = $button_A[$i] Then
                    Local $sTempFile = @TempDir & '\UTZTemp\' & $exesName_A[$i] & '.exe'
                   If Not FileExists($sTempFile) Then

Else
    If Not Run($sTempFile) Then
        MsgBox(0, 'Error', 'Failed to run file.')
    EndIf
EndIf

                EndIf
            Next
    EndSwitch
WEnd

