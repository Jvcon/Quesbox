cando_RenameExchange:    ;MultiFile
    SplitPath ,CandySel_FirstFile,,CandySel_ParentPath,,  ;以第一行的父目录为“多文件的父目录”
    ArrayCount=0
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        ArrayCount += 1  ;记录在数组中有多少个项目。
        Array%ArrayCount% := RegExReplace(A_loopfield,"(.*)\r.*","$1")
    }
    SplitPath ,Array1,,,MyExt1,MyNameNoExt1
    SplitPath ,Array2,,,MyExt2,MyNameNoExt2
    MyTem=%CandySel_ParentPath%\Tem.%MyExt1%
    MyNew1=%CandySel_ParentPath%\%MyNameNoExt2%.%MyExt1%
    MyNew2=%CandySel_ParentPath%\%MyNameNoExt1%.%MyExt2%
    FileMove,%Array1%,%MyTem%
    FileMove,%Array2%,%MyNew2%
    FileMove,%MyTem%,%MyNew1%
Return
;=======================================================
cando_RenameFolderWithClipboard: ;Folder
    CurDir=%Clipboard%
    SplitPath,CandySel,MyOutFileName,MyOutDir,MyOutExt,MyOutNameNoExt,MyOutDrive
    MyNewFile =%MyOutDir%\%Clipboard%
    FileMovedir,%CandySel%,%MyNewFile%
Return
;=======================================================
cando_RenameFileWithClipboard:   ;File
    MyCopyName=%Clipboard%
    MyTemFile := RegExReplace(candysel,"(.*)\r.*","$1")
    SplitPath ,MyTemFile,,,MyExt,MyNameNoExt
    MyNewFile =%CandySel_ParentPath%\%MyCopyName%.%MyExt%
    FileMove,%MyTemFile%,%MyNewFile%
Return
;=======================================================
cando_RenameAddPrefixWithInput:   ;File,Folder,Multifile
    Inputbox, MyInsert, 提示,请输入要添加的内容 
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        SplitPath,MyTemFile,MyOutFileName,MyOutDir,MyOutExt,MyOutNameNoExt,MyOutDrive
        If InStr(FileExist(MyTemFile), "D")
        {
            MyNewFile =%MyOutDir%\%MyInsert%%MyOutNameNoExt%
            FileMovedir,%MyTemFile%,%MyNewFile%
        } else {
            MyNewFile =%MyOutDir%\%MyInsert%%MyOutNameNoExt%.%MyOutExt%
            FileMove,%MyTemFile%,%MyNewFile%
        }
    }
Return
;=======================================================
cando_RenameAddSufixWithInput:   ;File,Folder,Multifile
    Inputbox, MyInsert, 提示,请输入要添加的内容
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        SplitPath,MyTemFile,MyOutFileName,MyOutDir,MyOutExt,MyOutNameNoExt,MyOutDrive
        If InStr(FileExist(MyTemFile), "D")
        {
            MyNewFile =%MyOutDir%\%MyOutNameNoExt%%MyInsert%
            FileMovedir,%MyTemFile%,%MyNewFile%
        } else {
            MyNewFile =%MyOutDir%\%MyOutNameNoExt%%MyInsert%.%MyOutExt%
            FileMove,%MyTemFile%,%MyNewFile%
        }
    }
Return
;=======================================================
cando_RenameAddPrefixWithDate:   ;File,Folder,Multifile
    CurDate=%a_yyyy%%a_mm%%a_dd%-
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        SplitPath,MyTemFile,MyOutFileName,MyOutDir,MyOutExt,MyOutNameNoExt,MyOutDrive
        If InStr(FileExist(MyTemFile), "D")
        {
            MyNewFile =%MyOutDir%\%CurDate%%MyOutNameNoExt%
            FileMovedir,%MyTemFile%,%MyNewFile%
        } else {
            MyNewFile =%MyOutDir%\%CurDate%%MyOutNameNoExt%.%MyOutExt%
            FileMove,%MyTemFile%,%MyNewFile%
        }
    }
Return
;=======================================================
cando_RenameAddSufixWithDate:   ;File,Folder,Multifile
    CurDate=-%a_yyyy%%a_mm%%a_dd%
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        SplitPath,MyTemFile,MyOutFileName,MyOutDir,MyOutExt,MyOutNameNoExt,MyOutDrive
        If InStr(FileExist(MyTemFile), "D")
        {
            MyNewFile =%MyOutDir%\%MyOutNameNoExt%%CurDate%
            FileMovedir,%MyTemFile%,%MyNewFile%
        } else {
            MyNewFile =%MyOutDir%\%MyOutNameNoExt%%CurDate%.%MyOutExt%
            FileMove,%MyTemFile%,%MyNewFile%
        }
    }
Return
;=======================================================
cando_RenameRemoveExt:   ;File,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        If InStr(FileExist(MyTemFile), "D")
            continue
        SplitPath ,MyTemFile,,,MyExt,MyNameNoExt
        MyNewFile =%CandySel_ParentPath%\%MyNameNoExt%
        FileMove,%MyTemFile%,%MyNewFile%
    }
return
;=======================================================
cando_RenameAddExt:  ;File,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        If InStr(FileExist(MyTemFile), "D")
            continue
        SplitPath ,MyTemFile,,,MyExt,MyNameNoExt
        Inputbox, MyNewExt, 提示,请输入新的后缀名 
        if MyNewExt="" 
            return
        MyNewFile =%CandySel_ParentPath%\%MyNameNoExt%.%MyExt%.%MyNewExt%
        FileMove,%MyTemFile%,%MyNewFile%
    }
return
;=======================================================
cando_RenameAddExtMenu:  ;File,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        If InStr(FileExist(MyTemFile), "D")
            continue
        SplitPath ,MyTemFile,,,MyExt,MyNameNoExt
        If %A_ThisMenuItem%="Custom"
            Inputbox, MyNewExt, 提示,请输入新的后缀名 
            if MyNewExt="" 
                return
            MyNewFile =%CandySel_ParentPath%\%MyNameNoExt%.%MyExt%.%MyNewExt%
        If %A_ThisMenuItem%!="Custom"
            MyNewFile =%CandySel_ParentPath%\%MyNameNoExt%.%MyExt%.%A_ThisMenuItem%
        FileMove,%MyTemFile%,%MyNewFile%
    }
return
;=======================================================
cando_RenameReplaceExt:   ;File,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        If InStr(FileExist(MyTemFile), "D")
            continue
        SplitPath ,MyTemFile,,,MyExt,MyNameNoExt
        Inputbox, MyNewExt, 提示,请输入新的后缀名 
        if MyNewExt="" 
            return
        MyNewFile =%CandySel_ParentPath%\%MyNameNoExt%.%MyNewExt%
        FileMove,%MyTemFile%,%MyNewFile%
    }
return