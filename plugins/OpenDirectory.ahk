OpenDir(target,key,state){
    DetectHiddenWindows,on
    global tc,tc_ini
    If key = 1
    {
        If (SubStr(Trim, target, 0)!="`\")
            target.="`\"
        tabs_ini:=getTabs_ini(tc,tc_ini)
        OutputDebug,  %tabs_ini%
        IfExist, %tabs_ini%
        {
            sendTCCommand(580,0)
            Sleep, 200
        }
        Else
        {
            MsgBox, , 请修改配置文件, %tc_ini%中的`nRedirectSection=路径存在错误
            Return
        }

        isFinded=-1
        rightArray:=getRightArray(tabs_ini)
        printArray(rightArray)
        for index, element in rightArray{
            If target=%element%
            {
                isFinded:=2
                targetNum:=5300+index+1
                OutputDebug,在右侧检测到%element%,激活%targetNum%
            }
        }
        leftArray:=getLeftArray(tabs_ini)
        printArray(leftArray)
        for index, element in leftArray{
            If target=%element%
            {
                isFinded:=1
                targetNum:=5200+index+1
                OutputDebug,在右侧检测到%element%,激活%targetNum%
            }
        }
        If isFinded>0
        {
            OutputDebug,isFinded=%isFinded%  找到激活之
            activeTC(tc,targetNum)
        }
        Else{
            OutputDebug,isFinded=%isFinded%  未找到打开之
            If state = D ;在右侧打开
                tc_cmd=`"%tc%`"  /O  /T  /R=`"%target%`"
            Else
                tc_cmd=`"%tc%`"  /O  /T  /L=`"%target%`"
            Run %tc_cmd%
        }
    }
    Else
    {
        Run, %target%,, Max
    }
}

getTabs_ini(ByRef  tc,ByRef  tc_ini){
    IfExist,TOTALCMD.EXE
        tc=%A_WorkingDir%\TOTALCMD.EXE
    Else
      {
        IfNotExist, %tc%
          {
            MsgBox 请直接配置tc变量为tc全路径
            Return
          }
      }
    SplitPath,tc,,COMMANDER_PATH ;用于 COMMANDER_PATH
    IfExist,WINCMD.INI
        tc_ini=%A_WorkingDir%\WINCMD.INI
    Else
      {
        IfNotExist, %tc_ini%
          {
            MsgBox,请直接配置tc_ini变量为tc配置文件的全路径
            ExitApp
          }
      }

    IniRead, Test_Left_Section, %tc_ini%, left
    If InStr(Test_Left_Section,"RedirectSection")
      {
        Loop, Parse, Test_Left_Section, `n, `r
          {
            curline := Trim(A_LoopField)
            If  (InStr(curline,"RedirectSection"))
              {
                isRedirectSection=1
                redirect_ini := SubStr(A_LoopField,  InStr(A_LoopField, "=") + 1)
                StringReplace,tabs_ini,redirect_ini,`%COMMANDER_PATH`%,%COMMANDER_PATH%
              }
          }
      }
    Else
        tabs_ini:=tc_ini

    Return tabs_ini
}

getRightArray(tabs_ini){
    RightActiveTab=
    IniRead,RightActiveTab_Section, %tabs_ini%, Right
    Loop, Parse, RightActiveTab_Section, `n, `r  ;%a_tab%%a_Space%`r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"path"))
          {
            p:= InStr(A_LoopField, "=")
            RightActiveTab := SubStr(A_LoopField, p + 1)
            Break
          }
      }
    IniRead, Righttabs_Section, %tabs_ini%, righttabs
    RightHas:=-1
    RightActiveTabNum:=-1
    RightArray := Object()
    printlog=
    Loop, Parse, Righttabs_Section, `n, `r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"_path"))||(InStr(curline,"activetab"))
          {
            match1 := SubStr(A_LoopField, (p1:=InStr(A_LoopField, "_"))+1, (p2:= InStr(A_LoopField, "="))-p1-1 )
            match2 := SubStr(A_LoopField, p2 + 1)
            If  (match1="path") ;必须有括号括起
              {
                RightHas++
                RightArray[RightHas]:=match2
              }
            Else
              {
                RightActiveTabNum:=match2
              }
          }
      }
    RightArray.Insert(RightActiveTabNum,RightActiveTab)
    Return RightArray
}

getLeftArray(tabs_ini){
    LeftActiveTab=
    IniRead, LeftActiveTab_Section, %tabs_ini%, left
    Loop, Parse, LeftActiveTab_Section, `n, `r  ;%a_tab%%a_Space%`r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"path"))
          {
            p:= InStr(A_LoopField, "=")
            LeftActiveTab := SubStr(A_LoopField, p + 1)
            Break
          }
      }

    IniRead, lefttabs_Section, %tabs_ini%, lefttabs
    LeftHas:=-1
    LeftActiveTabNum:=-1
    leftArray := Object()
    printlog=
    Loop, Parse, lefttabs_Section, `n, `r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"_path"))||(InStr(curline,"activetab"))
          {
            match1 := SubStr(A_LoopField, (p1:=InStr(A_LoopField, "_"))+1, (p2:= InStr(A_LoopField, "="))-p1-1 )
            match2 := SubStr(A_LoopField, p2 + 1)
            If  (match1="path") ;必须有括号括起
              {
                LeftHas++
                leftArray[LeftHas]:=match2
              }
            Else
              {
                LeftActiveTabNum:=match2
              }
          }
      }
    leftArray.Insert(LeftActiveTabNum,LeftActiveTab)
    Return leftArray
}

printArray(Array){
    for index, element in Array
    {
      printlog.=index . "_path is " . element . "`n"
    }
    OutputDebug %printlog%
}

activeTC(tc, targetNum){
    IfWinExist, ahk_class TTOTAL_CMD
        WinActivate
    else
    {
        Run,%tc% /O
        WinWait, AHK_CLASS TTOTAL_CMD
    }
    PostMessage 1075, %targetNum%, 0, , AHK_CLASS TTOTAL_CMD	;ActiveTab
}

sendTCCommand( CommandID, xbWait=1 )
  { If (xbWait)
        SendMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
    Else
        PostMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
  }