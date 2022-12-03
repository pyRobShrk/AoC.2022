# Day 3
00:08:28  2036

00:36:03   8055

Part 1

    CHARS = LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1))
    =LET(input,A1:A300,
        L,LEFT(input,LEN(input)/2),
        R,RIGHT(input,LEN(input)/2),
        matches,BYROW(HSTACK(L,R),LAMBDA(r,
            MID(INDEX(r,2),MAX(IFERROR(FIND(chars(INDEX(r,1)),INDEX(r,2)),0)),1))),
        pos,CODE(matches),
        SUM(IF(pos>96,pos-96,pos-38)))
