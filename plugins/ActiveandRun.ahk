;	--------------------------
;	Run Application
;	--------------------------

ActiveandRun(winclass,software)
{
	DetectHiddenWindows, on 
	IfWinExist ahk_class %winclass%
		WinShow ahk_class %winclass%
		IfWinNotActive ahk_class %winclass%
			WinActivate ahk_class %winclass%
		else
		IfWinActive ahk_class %winclass%
			WinMinimize ahk_class %winclass%
	else 
		Run, %software%
}

#IF
	#e::
		ActiveandRun("TTOTAL_CMD",tc)
	Return
	#r::
		ActiveandRun("VirtualConsoleClass",cmder)
	Return
	#w::
		ActiveandRun("WeChatMainWndForPC",wechat)
	Return