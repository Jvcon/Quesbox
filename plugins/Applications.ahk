;	--------------------------
;	Run Application
;	--------------------------

RunSoftware(winclass, software)
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

Run_Wechat: 
	software = %wechat%
	winclass = WeChatMainWndForPC
	RunSoftware(winclass, software)
Return
	
	
Run_TC: 
	software = %tc%
	winclass = TTOTAL_CMD
	RunSoftware(winclass, software)
Return

Run_Cmder:
	software = %cmder%
	winclass = VirtualConsoleClass
	RunSoftware(winclass, software)
Return