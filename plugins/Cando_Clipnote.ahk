;=======================================================
cando_SaveTXT:     ;长文本/短文件
    TxtPath:=
    IniRead,TxtPath,%g_ConfFile%,General_Settings,Default_Save_Path
    if ErrorLevel
        TxtPath:=
    MyFun_SaveTxtFile(TxtPath,Candysel)
return
;=======================================================
cando_SaveTXTtoPath:     ;长文本/短文件
    TxtPath:=
    TxtPath:=A_ThisMenuItem
    IfNotExist ,%TxtPath%
        TxtPath:=
    MyFun_SaveTxtFile(TxtPath,Candysel)
return
;=======================================================
;保存Txt的函数
;SavePath,保存路径
;SaveText,要保存的内容
MyFun_SaveTxtFile(SavePath,SaveText)
{
    TxtName:=
    MySaveName:=
    Loop,parse,SaveText,`n     ;循环读取每一行
    {
        TxtName := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        TxtName:=trim(TxtName)
        StringReplace,TxtName,TxtName,`,,,all
        StringReplace,TxtName,TxtName,`\,,all
        StringReplace,TxtName,TxtName,`/,,all
        StringReplace,TxtName,TxtName,`:,,all
        StringReplace,TxtName,TxtName,`*,,all
        StringReplace,TxtName,TxtName,`?,,all
        StringReplace,TxtName,TxtName,`<,,all
        StringReplace,TxtName,TxtName,`>,,all
        StringReplace,TxtName,TxtName,`|,,all
        if TxtName!=
        {
            FirstLineLen:=strlen(TxtName)
            if FirstLineLen>20
                TxtName:=substr(TxtName,1,20)
            break
        }
    }
    if SavePath!=
        MySaveName:=SavePath . "\" . TxtName . ".txt"
    else
        MySaveName:=TxtName . ".txt"
    MyWF:=fileopen(MySaveName,"rw")
    if !IsObject(MyWF)
    {
        MsgBox 不能打开写入 %MySaveName% 文件
        return
    }
    else
    {
        MyWF.Write(SaveText)
        MyWF.Close()
    }
}