# Day 6

00:05:12  2177
 
00:06:31   2157
 
One of the easiest to implement in Excel, but seemingly difficult to implement in a single formula. As always input pasted in A1.
 
    chars =LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1))
    A2 =chars(A1)
    B5 =COUNTA(UNIQUE(A2:A5))=4
    C15 =COUNTA(UNIQUE(A2:A15))>13
    B1 =MIN(IF(B5:B4096,ROW(B5:B4096),""))-1
 
Drag B5 and C15 down to row 4096. Drag B1 to C1.
