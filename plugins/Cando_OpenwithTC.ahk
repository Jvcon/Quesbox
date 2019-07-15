#SingleInstance,force
;FileName:OpenInTC.ahk
; File encoding:  UTF-8 BOM
/*
AutoHotkey 版本: 1.1.9.0
操作系统:    Windows XP/Vista/7
作者:        sunwind <1576157@qq.com>
博客:        http://blog.csdn.net/liuyukuan
设计目的：[ahk]让TC 识别已经打开的路径tab，若已存在则仅激活不重复打开。
设计思路：先保存当前配置，再检测其是否存在要打开的标签
功能：
1.新开tab标签如果已存在则激活，若不存在则打开之
2.按住shift 右侧窗口激活，不按左侧
3.接收路径以参数形式传给本脚本，可以为candy等工具调用 
在candy的配置中设置菜单项:  在tc中打开             =cango|openWithTC|"{file:pathfull}"
4.兼容路径 末尾无\ 的情况
5.兼容带空格路径
6.兼容wincmd.ini中RedirectSection的情况
7.修正最小化在托盘中时激活的bug
8.用ScrollLock状态来识别，左侧还是右侧
形如[Left] RedirectSection=%COMMANDER_PATH%\USER\user.ini

若把本脚本放到TOTALCMD.EXE所在目录则免配置
否则，可以以命令行参数指定wincmd.ini路径，不指定则需要配置本脚本的tc_exe

脚本版本：   v1.7
时间戳:20130227 0:15:47
*/
SetWorkingDir %A_ScriptDir%

cando_OpenwithTC:
    GetKeyState, state, Shift
    target=%CandySel%
    OpenDir(target,1,state)
    Return