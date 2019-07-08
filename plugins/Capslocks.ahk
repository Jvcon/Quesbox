!z::
	IfWinExist, ahk_class TTOTAL_CMD
        {	WinActivate
			Totalcmd_GetPath()
			
		}
Return
		
Totalcmd_GetPath(){
	IfWinExist, ahk_class TTOTAL_CMD
        {	WinActivate
			PostMessage 1075,2029,0,,ahk_class TTOTAL_CMD
		}
	return
}