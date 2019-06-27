#SingleInstance force
#Persistent
;SendMode Input

; 配置文件
global g_ConfFile := A_ScriptDir . "\Conf.ini"
global g_Conf := class_EasyIni(g_ConfFile)

global p_runz ="%A_ScriptDir%\runz\RunZ.ahk"
global p_tc = "d:\Applications\Scoop\apps\totalcmd\current\TOTALCMD.EXE"
global p_ahk = "d:\Applications\Scoop\apps\autohotkey\current\AutoHotkeyU64.exe"
global p_cmder = "D:\Applications\Scoop\apps\cmder\current\cmder.exe"
global p_wechat = "C:\Program Files (x86)\Tencent\WeChat\WeChat.exe"

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

;	--------------------------
;	Application Alias
;	--------------------------

#`:: 
	{ 
		DetectHiddenWindows, on 
			if WinExist("ahk_exe WeChat.exe")
				WinActivate, ahk_class WeChatMainWndForPC
			else 
				Run, %p_wechat%
	} 
	return
	
#r:: 
	{ 
		DetectHiddenWindows, on 
			IfWinExist Cmder
				WinActivate
			else 
				Run, %p_cmder%
	} 
	return

;	--------------------------
;	Windows 10 Virtual Desktop
;	--------------------------
!`::
send #{Tab} 
Return 
!2::
send #^{right} 
return 
!1::
send #^{left}
return

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

#include %A_ScriptDir%\lib\EasyIni.ahk