﻿#SingleInstance, Force
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

global love := chr(9829)
global copyright := chr(169)

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
If (g_Conf.Module.Candy){
    global szMenuIdx := {}             ;菜单用1
    global szMenuContent := {}         ;菜单用2
    global szMenuWhichFile := {}       ;菜单用3
    for key, label in g_Conf.Candy{
        if (label != "Default"){
            Hotkey, %key%, Label_Candy_Start, ,On, UseErrorLevel
            If ErrorLevel  ;热键出错
                MsgBox, 54,,  % "您定义的Candy热键:"   RegExReplace(label, "(^\s*)|(\s*$)" )   "不可用，请检查!"
        }
        else{
            Hotkey, %key%, Off
        }
    }
}
If (g_Conf.Module.Capslocks){
    global CapslocksStatus :=  0
    global CapslocksFnActed := 0
    global Mode_Normal := 0
    global Mode_Fn := 1
    global Mode_Capslocks := 2
    global Mode_Fns :=3
    global LastLightStatus := ((CapslocksStatus & Mode_Capslocks) || (CapslocksStatus & Mode_Fn))
    global FnStatus := (CapslocksStatus & Mode_Fn)
    for key, label in g_Conf.Capslocks{
        if (label != "Default"){
            Hotkey, %key%, %label%, ,On, UseErrorLevel
            If ErrorLevel  ;热键出错
                MsgBox, 54,, % "您定义的热键:"  RegExReplace(label, "(^\s*)|(\s*$)" ) "不可用，请检查!"
        }
        else{
            Hotkey, %key%, Off
        }
    }
}
if(g_Conf.Module.Todo){
    global ADD_LABEL := "Add:"
    global PROJECT_LABEL := "Project:"
    global CONTEXT_LABEL := "Context:"
    global ITEMS_LABEL := "Items:"

    global NONE_TEXT := "(None)"
    global ALL_TEXT := "(All)"

    global CHECK_COLUMN := 1
    global TEXT_COLUMN := 2
    global CONTEXT_COLUMN := 3
    global PROJECT_COLUMN := 4

    global CHECK_HEADER := ""
    global TEXT_HEADER := "Description"
    global CONTEXT_HEADER := "Context"
    global PROJECT_HEADER := "Project"
    global LINE_NUMBER_HEADER := "Line #"

    global ADD_BUTTON_TEXT := "Add"
    global ARCHIVE_BUTTON_TEXT := "Archive"

    global CONTROL_WIDTH := 400

    global UPDATE_PROMPT := "What do you want to change ""`%text`%"" to?"
    global DELETE_PROMPT := "Are you sure you want to delete ""`%text`%""?"

    global TODO_PATH := A_ScriptDir . "\data\todo.txt"
    global DONE_PATH := A_ScriptDir . "\data\done.txt"
}
Menu, Tray, UseErrorLevel
Sub_CreateTrayMenu()

Return

    #Include %A_ScriptDir%\lib\EasyIni.ahk
    #Include %A_ScriptDir%\lib\Anchor.ahk
    #Include %A_ScriptDir%\plugins\Tray.ahk
    #Include %A_ScriptDir%\plugins\OpenDirectory.ahk
    #Include %A_ScriptDir%\plugins\HashCalc.ahk
    #Include %A_ScriptDir%\plugins\todo.ahk

#If
    If (g_Conf.Module.Capslocks){
        #Include %A_ScriptDir%\plugins\Capslocks.ahk
        #Include %A_ScriptDir%\plugins\Capslocks_Windows10.ahk
        #Include %A_ScriptDir%\plugins\Capslocks_mstsc.ahk
        #Include %A_ScriptDir%\plugins\Capslocks_edit.ahk
    }
; #If
;     #Include %A_ScriptDir%\plugins\Windows10.ahk
#If
    If (g_Conf.Module.Candy){
        #Include %A_ScriptDir%\plugins\Candy.ahk
        #Include %A_ScriptDir%\plugins\Cando_OpenwithTC.ahk
        #Include %A_ScriptDir%\plugins\Cando_Rename.ahk
        #Include %A_ScriptDir%\plugins\Cando_MoveAndCopy.ahk
        #Include %A_ScriptDir%\plugins\Cando_Clipnote.ahk
        #Include %A_ScriptDir%\plugins\Cando_Create.ahk
        #Include %A_ScriptDir%\plugins\Cando_Hash.ahk
    }