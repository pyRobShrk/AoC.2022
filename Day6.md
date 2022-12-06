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

Even though it's much uglier, here's a single cell formula for parts 1 and 2:

    =LET(input,A1,length,LEN(input),
        fours,MID(input,SEQUENCE(length-3),4),
        fourteens,MID(input,SEQUENCE(length-13),14),
        chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        matchct,LAMBDA(s,SUM(1*(EXACT(TRANSPOSE(chars(s)),chars(s))))),
        matches,MAP(fours,matchct),matches2,MAP(fourteens,matchct),
        VSTACK(MIN(IF(matches=4,SEQUENCE(length-3,,4))),
            MIN(IF(matches2=14,SEQUENCE(length-13,,14)))))
