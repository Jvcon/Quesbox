cando_stringHash:
    type=%A_ThisMenuItem%
    if (type="MD2")
    {
        Hash := CalcStringHash(CandySel, 0x8001, encoding = "UTF-8")
    }
    if type=="MD4"
    {   
        Hash := CalcStringHash(CandySel, 0x8002, encoding = "UTF-8")
    }
    if type=="MD5"
    {
         Hash := CalcStringHash(CandySel, 0x8003, encoding = "UTF-8")
    }
    if type=="SHA-1"
    {
        Hash := CalcStringHash(CandySel, 0x8004, encoding = "UTF-8")
    }
    if type=="SHA-256"
    {
        Hash := CalcStringHash(CandySel, 0x800c, encoding = "UTF-8")
    }
    if type=="SHA-384"
    {
        Hash := CalcStringHash(CandySel, 0x800d, encoding = "UTF-8")
    }
    if type=="SHA-512"
    {
        Hash := CalcStringHash(CandySel, 0x800e, encoding = "UTF-8")
    }
    ToolTip, %Hash%
    Clipboard := Hash
Return

cando_fileHash:
    type=%A_ThisMenuItem%
    MsgBox, , , %CandySel%
    if (type="MD2")
    {
        Hash := CalcFileHash(CandySel, 0x8001, 64 * 1024)
    }
    if type=="MD4"
    {
         Hash := CalcFileHash(CandySel, 0x8002, 64 * 1024)
    }
    if type=="MD5"
    {
         Hash := CalcFileHash(CandySel, 0x8003, 64 * 1024)
    }
    if type=="SHA-1"
    {
        Hash := CalcFileHash(CandySel, 0x8004, 64 * 1024)
    }
    if type=="SHA-256"
    {
        Hash := CalcFileHash(CandySel, 0x800c, 64 * 1024)
    }
    if type=="SHA-384"
    {
        Hash := CalcFileHash(CandySel, 0x800d, 64 * 1024)
    }
    if type=="SHA-512"
    {
        Hash := CalcFileHash(CandySel, 0x800e, 64 * 1024)
    }
    ; ToolTip, %Hash%
    Clipboard := Hash
Return