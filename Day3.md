# Day 3
00:08:28  2036

00:36:03   8055

I had an error that took me quite a while on part 2.
Originally I had the UNIQUE() function in matches().
Apparently Excel considers "U" and "u" to be one unique string.
C'mon Microsoft, at least make case sensitivity an optional argument.

    chars =LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1))
    matches =LAMBDA(one,two,CONCAT(IFERROR(MID(two,FIND(chars(one),two),1),"")))
    
    =LET(input,A1:A300,
        L,LEFT(input,LEN(input)/2),
        R,RIGHT(input,LEN(input)/2),
        items,BYROW(HSTACK(L,R),LAMBDA(r,
            matches(INDEX(r,1),INDEX(r,2)))),
        pos,CODE(items),
        SUM(IF(pos>96,pos-96,pos-38)))

    =LET(input,A1:A300,
        data,WRAPROWS(input,3),
        groups,BYROW(data,LAMBDA(r,
            matches(matches(INDEX(r,1),INDEX(r,2)),INDEX(r,3)))),
        pos,CODE(groups),
        SUM(IF(pos>96,pos-96,pos-38)))
