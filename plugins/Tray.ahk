Sub_CreateTrayMenu()
{
	
    Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
    Menu, Tray, Click, 1
    Menu, Tray, Tip, QuesBox
    ;Menu, Tray, Add
    Menu, tray, add, 编辑全局配置,TrayHandle_GeneralSettings
	Menu, tray, add, Capture and OCR(&O),Capture_OCR
    Menu, tray, add, Hash Calc(&C),HashCalc
    Menu, tray, add, Todo(&T),Todos
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
    ToolTip %state%
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

/*
;   Open Directory
*/