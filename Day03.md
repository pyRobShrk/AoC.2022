# Day 3
00:08:28  2036

00:36:03   8055

I had an error that took me quite a while on part 2.
Originally I had the UNIQUE() function in matches().
Apparently Excel considers "U" and "u" to be one unique string.
C'mon Microsoft, at least make case sensitivity an optional argument.

    chars =LAMBDA(str,
        MID(str,SEQUENCE(LEN(str)),1))
    matches =LAMBDA(one,two,
        CONCAT(IFERROR(MID(two,FIND(chars(one),two),1),"")))
    
    =LET(input,A1:A300,
        L,LEFT(input,LEN(input)/2),
        R,RIGHT(input,LEN(input)/2),
        pos,CODE(MAP(L,R,LAMBDA(a,b,matches(a,b)))),
        SUM(IF(pos>96,pos-96,pos-38)))

    =LET(input,A1:A300,
        groups,BYROW(WRAPROWS(input,3),LAMBDA(r,
            matches(matches(INDEX(r,1),INDEX(r,2)),INDEX(r,3)))),
        pos,CODE(groups),
        SUM(IF(pos>96,pos-96,pos-38)))

And, for no practical reason whatsoever, combined into one cell formula:

    =LET(input,A1:A300,
        chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        matches,LAMBDA(one,two,CONCAT(IFERROR(MID(two,FIND(chars(one),two),1),""))),
        pos,CODE(MAP(LEFT(input,LEN(input)/2),RIGHT(input,LEN(input)/2),LAMBDA(a,b,matches(a,b)))),
        groups,CODE(BYROW(WRAPROWS(input,3),LAMBDA(r,
            matches(matches(INDEX(r,1),INDEX(r,2)),INDEX(r,3))))),
        score,LAMBDA(p,SUM(IF(p>96,p-96,p-38))),
        VSTACK(score(pos),score(groups)))
