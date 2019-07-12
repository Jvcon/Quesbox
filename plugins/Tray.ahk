Sub_CreateTrayMenu()
{
	
    Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
    Menu, Tray, Click, 1
    Menu, Tray, Tip, QuesBox
    ;Menu, Tray, Add
    Menu, tray, add, 编辑全局配置,TrayHandle_GeneralSettings
    Menu, tray, add, Hash Calc(&C),HashCalc
    Menu, Tray, Add, Directory(&D), TrayHandle_OpenSourceDir
    Menu, Tray, Add, Restart(&R)`tCtrl + Alt + R, TrayHandle_ReLoad
    Menu, Tray, Add, Exit(&E)`tCtrl + Alt + X, TrayHandle_Exit
    Menu, Tray, NoStandard 
}

/*
;   Tray Handle
*/
TrayHandle_OpenSourceDir:
    path = "%A_ScriptDir%"
    OpenDir(1,path)
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
    Gosub ShowHashWindow
    Gosub ShowHashCalc
Return
/*
;   Open Directory
*/

OpenDir(key,target)
{
    if key = 1
    {
        tc_cmd = %tc% /O /T /R=%target%
        Run, %tc_cmd%
    }
    Else
        Run, %target%,, Max
}
Return
