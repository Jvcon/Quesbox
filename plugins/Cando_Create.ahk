cando_CreateFolderwithDate:  ;;File,Folder,Multifile;RightMenu
	CurDir=%a_yyyy%%a_mm%%a_dd%－%Clipboard%
	if CandySel_Ext=RightMenu
		FileCreateDir %CandySel%\%CurDir%
	else
		FileCreateDir %CandySel_ParentPath%\%CurDir%
return
;=======================================================
cando_CreateFolderwithClipboard:  ;;File,Folder,Multifile;RightMenu
	CurDir=%Clipboard%
	if CandySel_Ext=RightMenu
		FileCreateDir %CandySel%\%CurDir%
	else
		FileCreateDir %CandySel_ParentPath%\%CurDir%
return