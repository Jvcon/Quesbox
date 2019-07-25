;	--------------------------
;	Run Application
;	--------------------------

ActiveandRun(winclass,software)
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

#IF
	#w::
		ActiveandRun(winclass_wechat,wechat)
	Return
	#e::
		ActiveandRun(winclass_tc,tc)
	Return
	#r::
		ActiveandRun(winclass_cmder,cmder)
	Return
