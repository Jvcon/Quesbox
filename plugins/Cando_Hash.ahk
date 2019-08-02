cando_stringHash:
    type=%A_ThisMenuItem%
    Str=%CandySel%
    if (type="MD2")
    {
        Hash := MD2(Str)
    }
    if type=="MD4"
    {   
        Hash := MD4(Str)
    }
    if type=="MD5"
    {
         Hash := MD5(Str)
    }
    if type=="SHA-1"
    {
        Hash := SHA(Str)
    }
    if type=="SHA-256"
    {
        Hash := SHA256(Str)
    }
    if type=="SHA-384"
    {
        Hash := SHA384(Str)
    }
    if type=="SHA-512"
    {
        Hash := SHA512(Str)
    }
    MsgBox, %Hash%
    Clipboard := Hash
Return

cando_fileHash:
    type=%A_ThisMenuItem%
    Str=%CandySel%
    if (type="MD2")
    {
        Hash := FileMD2(Str)
    }
    if type=="MD4"
    {
         Hash := FileMD4(Str)
    }
    if type=="MD5"
    {
         Hash := FileMD5(Str)
    }
    if type=="SHA-1"
    {
        Hash := FileSHA(Str)
    }
    if type=="SHA-256"
    {
        Hash := FileSHA256(Str)
    }
    if type=="SHA-384"
    {
        Hash := FileSHA384(Str)
    }
    if type=="SHA-512"
    {
        Hash := FileSHA512(Str)
    }
    MsgBox, %Hash%
    Clipboard := Hash
Return