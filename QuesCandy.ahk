﻿/*
;	Head
*/

#SingleInstance, Force                                                                  ;Single Running
    #MaxThreadsPerHotkey, 9                                                                 ; 最大热键数量
#WinActivateForce                                                                       ;强制激活窗体
    #ClipboardTimeout 500                                                                   ;首次访问剪贴板失败后继续尝试访问剪贴板的持续时间

SetWorkingDir, %A_ScriptDir%                                                            ;Set Working Dir
SetBatchLines, -1                                                                       ;无休眠运行
ListLines, Off                                                                          
SendMode Input                                                                          ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode, 2                                                                    ; A window's title must exactly match WinTitle to be a match.
SplitPath, A_ScriptName, , , , thisscriptname
Process Priority,,High                                                                  ;线程,主,高级别
coordmode,Mouse,screen                                                                  ;设置鼠标相对于屏幕激活
coordmode,Menu                                                                          ;设置菜单相对于窗口激活
AutoTrim,on                                                                             ;自动省略首尾的空格和Tab
SetCapsLockState, AlwaysOff                                                             ;For Capslock,set the State AlwaysOFF

; DetectHiddenWindows, On
; SetWinDelay, -1 ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
; SetKeyDelay, -1, -1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay, -1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag

/*
;	Configuration
*/

; Startup Status
global Ky_RunWithSystem:=0 
global szMenuIdx:={}                 ;菜单用1
global szMenuContent:={}         ;菜单用2
global szMenuWhichFile:={}      ;菜单用3

; Configuration File
global g_ConfFile := A_ScriptDir . "\config\GeneralSettings.ini"

if !FileExist(g_ConfFile)
{
    FileCopy, %g_ConfFile%.help.txt, %g_ConfFile%
}

global g_Conf := class_EasyIni(g_ConfFile)

/*
;	Enviroment Init
*/

for key, label in g_Conf.MyVar
{
    MyVar_Key:= RegExReplace(key, "(^\s*)|(\s*$)" )                                         ;用户自定义变量的key
    MyVar_Val:= RegExReplace(label, "(^\s*)|(\s*$)" )                                       ;用户自定义变量的value,
    if (MyVar_Key && MyVar_Val && not instr(MyVar_Key," "))                                 ;抛弃空变量以及含空格的变量
        %MyVar_Key%=%MyVar_Val%                                                
}


/*
;	Hotkey Binding
*/

for key, label in g_Conf.Hotkeys
{
    if (label != "Default")
    {
        Hotkey, %key%, %label%, ,On, UseErrorLevel
        If ErrorLevel  ;热键出错
            MsgBox % "您定义的热键:"   RegExReplace(label, "(^\s*)|(\s*$)" )   "不可用，请检查!"
    }
    else
    {
        Hotkey, %key%, Off
    }
}

for key, label in g_Conf.Candy
{
    if (label != "Default")
    {
        Hotkey, %key%, Label_Candy_Start, ,On, UseErrorLevel
        If ErrorLevel  ;热键出错
            MsgBox % "您定义的Candy热键:"   RegExReplace(label, "(^\s*)|(\s*$)" )   "不可用，请检查!"
    }
    else
    {
        Hotkey, %key%, Off
    }
}

Sub_CreateTrayMenu()

Return

/*
;   Create Tray Menu
*/

Sub_CreateTrayMenu()
{
    Menu, Tray, Icon, %A_ScriptDir%\src\quesbox.ico
    Menu, Tray, Click, 1
    Menu, Tray, Tip, QuesBox
    Menu, Tray, Add
    Menu, tray, add, 编辑全局配置,TrayHandle_GeneralSettings
    Menu, Tray, Add, Directory(&D), TrayHandle_OpenSourceDir
    Menu, Tray, Add, Restart(&B)`tCtrl + Alt + R, TrayHandle_ReLoad
    Menu, Tray, Add, Exit(&X)`tCtrl + Alt + X, TrayHandle_Exit
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


#include %A_ScriptDir%\lib\EasyIni.ahk
#include %A_ScriptDir%\plugins\Windows10.ahk
#include %A_ScriptDir%\plugins\Applications.ahk
#include %A_ScriptDir%\plugins\Capslock.ahk
#include %A_ScriptDir%\plugins\Candy.ahk