;=======================================================
cando_MoveAndCopy:   ;File,Folder,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        SplitPath,MyTemFile, SourceFolderName ; 仅从它的完全路径提取文件夹名称。
        If InStr(FileExist(MyTemFile), "D")  ;区分是否文件夹,Attrib= D ,则是文件夹
        {
            if Ky_ShiftIsPressed=
                FileCopyDir, %MyTemFile%, %A_ThisMenuItem%\%SourceFolderName%、
            else
                FilemoveDir, %MyTemFile%, %A_ThisMenuItem%\%SourceFolderName%
        } Else  {
            if Ky_ShiftIsPressed=
                filecopy,%MyTemFile%,%A_ThisMenuItem%
            else
                filemove,%MyTemFile%,%A_ThisMenuItem%
        }
    }
    Ky_ShiftIsPressed:=
        return
;=======================================================
cando_MoveToParent:  ;File,Folder,Multifile
    Loop,parse,candysel,`n     ;循环读取每一行
    {
        MyTemFile := RegExReplace(A_loopfield,"(.*)\r.*","$1")
        If InStr(FileExist(MyTemFile), "D")  ;区分是否文件夹,Attrib= D ,则是文件夹
        {
            splitpath,MyTemFile,SourceFolderName ,MyParentDir ; 提取当前文件的所在文件夹名称。
            splitpath,MyParentDir, ,MyParentDir ; 提取当前文件的所在文件夹的父文件夹名称。
            run,%Unlocker% %MyTemFile%
            FilemoveDir, %MyTemFile%, %MyParentDir%\%SourceFolderName%
        }
        Else 
        {
            splitpath,MyTemFile, ,MyParentDir ; 提取当前文件的所在文件夹名称。
            splitpath,MyParentDir, ,MyParentDir ; 提取当前文件的所在文件夹的父文件夹名称。
            run,%Unlocker% %MyTemFile%
            filemove,%MyTemFile%,%MyParentDir%
        }
    }
return