Sub_CreateTrayMenu()
{
    Pinyin_Status:=Get_Pinyin_Status()
    Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
    Menu, Tray, Click, 1
    Menu, Tray, Tip, QuesBox
    ;Menu, Tray, Add
    Menu, tray, add, Double Pinyin,Pinyin_Switch 
    ; Menu, tray, Check, Double Pinyin
    if Pinyin_Status{
        Menu, tray, Check, Double Pinyin
    }else{
        Menu, tray, Uncheck, Double Pinyin
    }
    Menu, tray, add
    Menu, tray, add, Test, TestCalc
	Menu, tray, add, Capture and OCR(&O), Capture_OCR
    Menu, tray, add, Hash Calc(&C), HashCalc
    Menu, tray, add, Todo(&T), Todos
    Menu, tray, add
    Menu, tray, add, Global Settings, TrayHandle_GeneralSettings
    Menu, Tray, Add, Directory(&D), TrayHandle_OpenSourceDir
    Menu, Tray, Add, Restart(&R)`tCtrl + Alt + R, TrayHandle_ReLoad
    Menu, Tray, Add, Exit(&E)`tCtrl + Alt + X, TrayHandle_Exit
    Menu, Tray, NoStandard 
}

/*
;   Tray Handle
*/
TrayHandle_OpenSourceDir:
    target = "%A_ScriptDir%"
    GetKeyState, state, Shift, T
    ;ToolTip %state%
    OpenDir(target,1,state)
Return

TrayHandle_GeneralSettings:
    SkSub_EditConfig(g_ConfFile,"")
return

TrayHandle_ReLoad:
    Reload
Return

TrayHandle_Exit:
    ExitApp
Return

/*
;   Functions
*/
HashCalc:  
    Gosub ShowHashCalc
Return

Todos:
    ShowTodo()
Return

Capture_OCR:
	Clipboard := TextRecognize(,"eng+chi_sim",,{"previewBounds":false,"splashText":false})
	msgbox % Clipboard
Return

Get_Pinyin_Status(){
    RegRead, Pinyin_Status, HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS, Enable Double Pinyin
    Return Pinyin_Status
}

Pinyin_Switch:
Pinyin_Status:=Get_Pinyin_Status()
if Pinyin_Status{
    RegWrite, REG_DWORD, HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS, Enable Double Pinyin, 0
    ToolTip , Full Pinyin
    SetTimer, RemoveTooltip, -5000
    Menu, tray, Uncheck, Double Pinyin
}else{
    RegWrite, REG_DWORD, HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS, Enable Double Pinyin, 1
    ToolTip , Double Pinyin
    SetTimer, RemoveTooltip, -5000
    Menu, tray, Check, Double Pinyin
}
Return

RemoveTooltip:
    ToolTip
Return