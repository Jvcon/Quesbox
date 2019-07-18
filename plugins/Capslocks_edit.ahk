#If (CapslocksStatus & Mode_Fn)
    Space:: Enter
    ; Move
    ; u::PgUp             ;~ Pre Page
    ; d::PgDn             ;~ Next Page

    h::Left             ;~ ← Move to left
    l::Right            ;~ → Move to right 
    k::Up               ;~ ↑ Move to up
    j::Down             ;~ ↓ Move to down

    n::^Left
    m::^Right

    ,::send, {Home}     ;~ Move to first line
    .::send, {End}      ;~ Move to end of line

    u::send, ^{Home}   ;~ Move to top
    d::send, ^{End}     ;~ move to Bottom

    ;Select
    +h::+Left             ;~ ← Select to the left
    +l::+Right            ;~ → Select to the right
    +k::+Up               ;~ ↑ Select to the up
    +j::+Down             ;~ ↓ Select to the down
    
    +n::^+Left            ;~ Select to the left word
    +m::^+Right           ;~ Select to the right word

    +,::send, +{Home}     ;~ Select to end of line
    +.::send, +{End}      ;~ Select to end of line
    
    +u::send, ^+{Home}    ;~ Select to top
    +d::send, ^+{End}     ;~ Select to Bottom