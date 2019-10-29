cando_stringHash:
    type=%A_ThisMenuItem%
    if (type="MD2")
    {
        Hash := MD2(Candysel)
    }
    if (type=="MD4")
    {   
        Hash := MD4(CandySel)
    }
    if (type=="MD5")
    {
        Hash := MD5(CandySel)
    }
    if (type=="SHA-1")
    {
        Hash := SHA(CandySel)
    }
    if (type=="SHA-256")
    {
        Hash := SHA256(CandySel)
    }
    if (type=="SHA-384")
    {
        Hash := SHA384(CandySel)
    }
    if (type=="SHA-512")
    {
        Hash := SHA512(CandySel)
    }
    ;ToolTip, %Hash%
    Clipboard := Hash
Return

cando_fileHash:
    type=%A_ThisMenuItem%
    MsgBox, , , %CandySel%
    if (type="MD2")
    {
        Hash := FileMD2(CandySel)
    }
    if (type=="MD4")
    {
         Hash := FileMD4(CandySel)
    }
    if (type=="MD5")
    {
         Hash := FileMD5(CandySel)
    }
    if (type=="SHA-1")
    {
        Hash := FileSHA(CandySel)
    }
    if (type=="SHA-256")
    {
        Hash := FileSHA256(CandySel)
    }
    if (type=="SHA-384")
    {
        Hash := FileSHA384(CandySel)
    }
    if (type=="SHA-512")
    {
        Hash := FileSHA512(CandySel)
    }
    ; ToolTip, %Hash%
    Clipboard := Hash
Return