/*
;   Global Head
*/

SetWorkingDir, %A_ScriptDir%        ;设置工作目录
#SingleInstance, Force              ;单脚本运行
#Persistent
#WinActivateForce                   ;强制激活窗体
#MaxThreadsPerHotkey, 9             ; 最大热键数量
#ClipboardTimeout 500               ;首次访问剪贴板失败后继续尝试访问剪贴板的持续时间
Process Priority,,High              ;线程,主,高级别
coordmode,Mouse,screen              ;设置鼠标相对于屏幕激活
coordmode,Menu                      ;设置菜单相对于窗口激活
SetTitleMatchMode,2                 ;设置WinWait等命令,匹配包含指定的 WinTitle 的窗口标题,精确匹配
DetectHiddenWindows On              ;不可见的窗口是否被脚本“看见”,是
AutoTrim,on                         ;自动省略首尾的空格和Tab
SetBatchLines, -1                   ;让脚本无休眠地执行（换句话说，也就是让脚本全速运行）
ComObjError(0)                               ;禁用  COM 错误通告
ListLines, Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SplitPath, A_ScriptName, , , , thisscriptname
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag



/*
;   Setting
*/



/*
;	Configuration
*/

; 配置文件
global g_ConfFile := A_ScriptDir . "\Conf.ini"

if !FileExist(g_ConfFile)
{
    FileCopy, %g_ConfFile%.help.txt, %g_ConfFile%
}

global g_Conf := class_EasyIni(g_ConfFile)

global p_runz = A_ScriptDir . "\runz\RunZ.ahk"
global p_tc = "d:\Applications\Scoop\apps\totalcmd\current\TOTALCMD.EXE"
global p_ahk = "d:\Applications\Scoop\apps\autohotkey\current\AutoHotkeyU64.exe"
global p_cmder = "D:\Applications\Scoop\apps\cmder\current\cmder.exe"
global p_wechat = "C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"


;	--------------------------
;	Hotkey Bindings
;	--------------------------
Hotkey, IfWinActive, % g_WindowName

Hotkey, ^!x, Menu_Tray_Exit
Hotkey, ^!r, Menu_Tray_Reload

for key, label in g_Conf.Hotkey
{
    if (label != "Default")
    {
        Hotkey, %key%, %label%
    }
    else
    {
        Hotkey, %key%, Off
    }
}


;	--------------------------
;	Tray Menu
;	--------------------------

Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
Menu, Tray, Click, 1
Menu, Tray, Tip, QuesBox
Menu, Tray, Add, RunZ(&R), Run_Runz
Menu, Tray, Add
Menu, Tray, Add, Directory(&D), Menu_Tray_OpenDir
Menu, Tray, Add, Restart(&B)`tCtrl + Alt + R, Menu_Tray_Reload
Menu, Tray, Add, Exit(&X)`tCtrl + Alt + X, Menu_Tray_Exit
Menu, Tray, NoStandard      

Return

;	--------------------------
;	QuesBox Menu Tray Fuction
;	--------------------------

;	启动RunZ
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

;	--------------------------
;	Fuction : OpenDir
;	--------------------------

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

;	--------------------------
;	Fuction : Swith Applications
;	--------------------------

RunSoftware(winclass,software)
{
	DetectHiddenWindows, on 
		IfWinExist ahk_class %winclass%
			IfWinNotActive ahk_class %winclass%
				WinActivate
			else
				WinMinimize ahk_class %winclass%
		else 
			Run, %software%
}
Return

#include %A_ScriptDir%\lib\EasyIni.ahk
#include %A_ScriptDir%\plugins\Applications.ahk
#include %A_ScriptDir%\plugins\Windows10.ahk
#include %A_ScriptDir%\plugins\Capslock.ahk