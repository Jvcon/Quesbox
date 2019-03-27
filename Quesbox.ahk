#SingleInstance force
#Persistent
;SendMode Input

p_runz ="%A_ScriptDir%\runz\RunZ.ahk"
global p_tc = "d:\Applications\Scoop\apps\totalcmd\current\TOTALCMD.EXE"
global p_ahk = "d:\Applications\Scoop\apps\autohotkey\current\AutoHotkeyU64.exe"

Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
Menu, Tray, Click, 1
Menu, Tray, Tip, QuesBox
Menu, Tray, Add, RunZ(&R), Run_Runz
Menu, Tray, Add
Menu, Tray, Add, Directory(&D), Menu_Tray_OpenDir
Menu, Tray, Add, Restart(&B), Menu_Tray_Reload
Menu, Tray, Add, Exit(&X)`tCtrl + Alt + X, Menu_Tray_Exit
Menu, Tray, NoStandard      

Return

Run_Runz:
    Run, %p_ahk% "%p_runz%"
Return

;  打开应用根目录
Menu_Tray_OpenDir:
    target = "%A_ScriptDir%"
    OpenDir(1,target)
Return

; 重启Manager
Menu_Tray_Reload:
    Reload
Return

; 退出
Menu_Tray_Exit:
    ExitApp
Return

OpenDir(key,target)
{
    if key = 1
    {
        tc_cmd = %p_tc% /O /T /R=%target%
        Run, %tc_cmd%
    }
    Else
        Run, %target%,, Max
}
Return