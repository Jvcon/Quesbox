#SingleInstance, Force
Process Priority, , High
UpdateCapslocksStatus(){
    CapslocksStatus := GetKeyState(CapsLock, "P")
    CapslocksStatus |= GetKeyState(ScrollLock, "T") << 1
    Return CapslocksStatus
}
UpdateCapslocksStatus()
UpdateLight(){
    NowLightStatus := ((CapslocksStatus & Mode_Capslocks) || (CapslocksStatus & Mode_Fn))
    ; a := CapslocksStatus & Mode_Capslocks
    ; b := CapslocksStatus & Mode_Fn
    ; c := a||b
    ; ToolTip, CapslocksStatus: %CapslocksStatus% `n Mode_Capslocks: %Mode_Capslocks% `n Mode_Fn: %Mode_Fn% `n (CapslocksStatus & Mode_Capslocks): %a% `n (CapslocksStatus & Mode_Fn): %b% `n NowLightStatus: %c%
    If (GetKeyState("ScrollLock", "T") != ((CapslocksStatus & Mode_Capslocks) || (CapslocksStatus & Mode_Fn))){
        Send {ScrollLock}
        Return 1
    }
    LastLightState := NowLightState
}
CapslocksTurnOff(){
    CapslocksStatus &= ~Mode_Capslocks
    re =: UpdateLight()
    Return re
}
CapslocksTurnOn(){
    CapslocksStatus |= Mode_Capslocks
    re =: UpdateLight()
    Return re
}
Return

Capslocks_Dn:
    CapslocksStatus |= Mode_Fn
    if (WinActive("ahk_class TscShellContainerClass ahk_exe mstsc.exe")){
        CapslocksStatus &= ~Mode_Fn
    }
    UpdateLight()
Return

Capslocks_Up:
    CapslocksStatus &= ~Mode_Fn
    CapslocksFnActed := CapslocksFnActed || (A_PriorKey != CapsLock && A_PriorKey != "Insert")
    If (!CapslocksFnActed){
        CapslocksStatus ^= ~Mode_Capslocks
        if (WinActive("ahk_class TscShellContainerClass ahk_exe mstsc.exe")){
            CapslocksStatus &= ~Mode_Capslocks
        }
    }
    CapslocksFnActed := 0
    UpdateLight()
Return

Capslock_Set:
    GetKeyState, CapsLockState, CapsLock, T
    if CapsLockState = D
        SetCapsLockState, AlwaysOff
    else
        SetCapsLockState, AlwaysOn
    KeyWait, ``
Return