#SingleInstance, Force
#WinActivateForce
#MaxThreadsPerHotkey, 300
#ClipboardTimeout, 500

SetWorkingDir, %A_ScriptDir%
Process Priority, , High
SendMode Input                 
SetBatchLines, -1
ListLines, Off
SetTitleMatchMode, 2
SplitPath, A_ScriptName, , , , thisscriptname
AutoTrim,on
coordmode,Mouse,screen
coordmode,Menu
SetCapsLockState, AlwaysOff

global g_ConfFile := A_ScriptDir . "\config\GeneralSettings.ini"

if !FileExist(g_ConfFile)
{
    FileCopy, %g_ConfFile%.help.txt, %g_ConfFile%
}

global g_Conf := class_EasyIni(g_ConfFile)

global load_capslocks := g_Conf.Module.Capslocks
global load_candy := g_Conf.Module.Candy

global CapslocksStatus :=  0
global CapslocksFnActed := 0
global Mode_Normal := 0
global Mode_Fn := 1
global Mode_Capslocks := 2
global Mode_Fns :=3
global LastLightStatus := ((CapslocksStatus & Mode_Capslocks) || (CapslocksStatus & Mode_Fn))
global FnStatus := (CapslocksStatus & Mode_Fn)

global szMenuIdx := {}             ;菜单用1
global szMenuContent := {}         ;菜单用2
global szMenuWhichFile := {}       ;菜单用3

for key, label in g_Conf.MyVar
{
    MyVar_Key:= RegExReplace(key, "(^\s*)|(\s*$)" )                                         ;用户自定义变量的key
    MyVar_Val:= RegExReplace(label, "(^\s*)|(\s*$)" )                                       ;用户自定义变量的value,
    if (MyVar_Key && MyVar_Val && not instr(MyVar_Key," "))                                 ;抛弃空变量以及含空格的变量
        %MyVar_Key%=%MyVar_Val%                                                
}
for key, label in g_Conf.Global_Hotkeys
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
If (load_candy){
    for key, label in g_Conf.Candy{
        if (label != "Default"){
            Hotkey, %key%, Label_Candy_Start, ,On, UseErrorLevel
            If ErrorLevel  ;热键出错
                MsgBox % "您定义的Candy热键:"   RegExReplace(label, "(^\s*)|(\s*$)" )   "不可用，请检查!"
        }
        else{
            Hotkey, %key%, Off
        }
    }
}
If (load_capslocks){
    for key, label in g_Conf.Capslocks{
        if (label != "Default"){
            Hotkey, %key%, %label%, ,On, UseErrorLevel
            If ErrorLevel  ;热键出错
                MsgBox % "您定义的热键:"   RegExReplace(label, "(^\s*)|(\s*$)" ) "不可用，请检查!"
        }
        else{
            Hotkey, %key%, Off
        }
    }
}
Menu, Tray, UseErrorLevel
Sub_CreateTrayMenu()
Return

#If
    #Include %A_ScriptDir%\lib\EasyIni.ahk
    #Include %A_ScriptDir%\plugins\Tray.ahk

#If
    If (load_capslocks){
        #Include %A_ScriptDir%\plugins\Capslocks.ahk
        #Include %A_ScriptDir%\plugins\Windows10.ahk

    }
; #If
;     #Include %A_ScriptDir%\plugins\Windows10.ahk
#If
    If (load_candy){
        #Include %A_ScriptDir%\plugins\Candy.ahk
        #Include %A_ScriptDir%\plugins\Cando_Rename.ahk
        #Include %A_ScriptDir%\plugins\Cando_MoveAndCopy.ahk
        #Include %A_ScriptDir%\plugins\Cando_Clipnote.ahk
        #Include %A_ScriptDir%\plugins\Cando_Create.ahk
    }