; 把当前窗口移到其它桌面
MoveActiveWindow(action){
	activeWin := WinActive("A")
	WinHide ahk_id %activeWin%
	Send %action%
	WinShow ahk_id %activeWin%
	WinActivate ahk_id %activeWin%
}
; x = 0 时新键桌面
MoveActiveWindowTo(x){
	; MoveActiveWindow("^#{Left 10}^#{Right "(0 == x ? "^#d" : x - 1) "}")
	MoveActiveWindow( 0 == x ? "^#d" : "^#{Left 10}^#{Right " (x - 1) "}")
}
SwitchToDesktop(x){
	Send % "^#{Left 10}^#{Right "(0 == x ? "^#d" : x - 1) "}"
}

; \::
; 	if FnStatus = 1
; 	{
; 		Send, #{Tab}
; 	}
; 	Else {
; 		SendInput, \
; 	}
; Return

#If (CapslocksStatus & Mode_Fn)
	\:: send #{Tab}

;         Return
;     }
;     Else{
;         send \
;         Break
;     }

; #If !!(Ky_CapslockXMode & Ky_Mode_Fn)
;     ; Win+Tab
; 	\:: Send #{Tab} 

; 	; 切换桌面
; 	[:: Send ^#{Left}
; 	]:: Send ^#{Right}

; 	; 移动当前窗口到其它桌面
; 	+[:: MoveActiveWindow("^#{Left}")
; 	+]:: MoveActiveWindow("^#{Right}")

;     ; 切换当前窗口置顶并透明
; 	'::
; 		; WinGet, Var, Transparent, 150, A
; 		WinSet, Transparent, 200, A
; 		Winset, Alwaysontop, , A
; 		Return
; 	+'::
; 		; WinGet, Var, Transparent, 150, A
; 		WinSet, Transparent, 255, A
; 		Winset, Alwaysontop, , A
; 		Return

; 	; 所有窗口透明
; 	`;::
; 		; WinGet, Var, Transparent, 150, A
; 		WinSet, Transparent, 100, A
; 		Return
	
; 	`; Up::
; 		; WinGet, Var, Transparent, 150, A
; 		WinSet, Transparent, 255, A
; 		Return