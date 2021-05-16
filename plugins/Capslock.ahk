;	--------------------------
;	Capsloack Fuction
;	--------------------------

; SetCapsLockState, AlwaysOff

;====================================================================o
;                       CapsLock Switcher:                          ;|
;---------------------------------o----------------------------------o
;                    CapsLock + ` | {CapsLock}                      ;|
;---------------------------------o----------------------------------o
Capslock & Space::                                                  ;|
GetKeyState, CapsLockState, CapsLock, T                             ;|
if CapsLockState = D                                                ;|
    SetCapsLockState, AlwaysOff                                     ;|
else                                                                ;|
    SetCapsLockState, AlwaysOn                                      ;|
KeyWait, ``                                                         ;|
return                                                              ;|
;--------------------------------------------------------------------o

;====================================================================o
;                    CapsLock Direction Navigator                   ;|
;-----------------------------------o--------------------------------o
;                      CapsLock + h |  Left                         ;|
;                      CapsLock + j |  Down                         ;|
;                      CapsLock + k |  Up                           ;|
;                      CapsLock + l |  Right                        ;|
;                      Ctrl, Alt Compatible                         ;|
;-----------------------------------o--------------------------------o
CapsLock & h::                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Left}                                                ;|
    else                                                            ;|
        Send, +{Left}                                               ;|
    return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Left}                                               ;|
    else                                                            ;|
        Send, +^{Left}                                              ;|
    return                                                          ;|
}                                                                   ;|
return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & j::                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Down}                                                ;|
    else                                                            ;|
        Send, +{Down}                                               ;|
    return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Down}                                               ;|
    else                                                            ;|
        Send, +^{Down}                                              ;|
    return                                                          ;|
}                                                                   ;|
return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & k::                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Up}                                                  ;|
    else                                                            ;|
        Send, +{Up}                                                 ;|
    return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Up}                                                 ;|
    else                                                            ;|
        Send, +^{Up}                                                ;|
    return                                                          ;|
}                                                                   ;|
return                                                              ;|
;----------------------------------o                                ;|
CapsLock & l::                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Right}                                               ;|
    else                                                            ;|
        Send, +{Right}                                              ;|
    return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Right}                                              ;|
    else                                                            ;|
        Send, +^{Right}                                             ;|
    return                                                          ;|
}                                                                   ;|
return                                                              ;|
;--------------------------------------------------------------------o


;====================================================================o
;                            CapsLock Editor                        ;|
;-----------------------------------o--------------------------------o
;                    CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                    CapsLock + x  |  Ctrl + x (Cut)                ;|
;                    CapsLock + c  |  Ctrl + c (Copy)               ;|
;                    CapsLock + v  |  Ctrl + z (Paste)              ;|
;                    CapsLock + a  |  Ctrl + a (Select All)         ;|
;                    CapsLock + y  |  Ctrl + y (Yeild)              ;|
;                    CapsLock + w  |  Ctrl + Right(Move as [vim: w]);|
;                    CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o--------------------------------o
CapsLock & z:: Send, ^z                                             ;|
CapsLock & x:: Send, ^x                                             ;|
CapsLock & c:: Send, ^c                                             ;|
CapsLock & v:: Send, ^v                                             ;|
CapsLock & a:: Send, ^a                                             ;|
CapsLock & y:: Send, ^y                                             ;|
CapsLock & w:: Send, ^{Right}                                       ;|
CapsLock & b:: Send, ^{Left}                                        ;|
;--------------------------------------------------------------------o

;====================================================================o
;                      CapsLock Window Controller                   ;|
;-----------------------------------o--------------------------------o
;                     CapsLock + Tab|  Ctrl + Tab (Swith Tag)       ;|
;                     CapsLock + q  |  Ctrl + W   (Close Tag)       ;|
;               Alt + CapsLock + q  |  Ctrl + Tab (Close Windows)   ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)        ;|
;-----------------------------------o---------------------------------o
CapsLock & Tab::Send, ^{Tab}                                        ;|
;-----------------------------------o                               ;|
CapsLock & q::                                                      ;|
if GetKeyState("alt") = 0                                           ;|
{                                                                   ;|
    Send, ^w                                                        ;|
}                                                                   ;|
else {                                                              ;|
    Send, !{F4}                                                     ;|
    return                                                          ;|
}                                                                   ;|
return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & g:: Send, {AppsKey}                                      ;|
;--------------------------------------------------------------------o