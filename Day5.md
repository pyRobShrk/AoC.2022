# Day 5
00:20:42  2947

00:21:51   2246

I solved this problem using cell formulas. With a little refactoring, I was able to get Part 2 into a single formula.
Part 1 is resisting due to an unknown error using CONCAT within the function.

Part 2:

    =LET(startingstacks,SUBSTITUTE(BYCOL(MID(A1:A8,SEQUENCE(,9,2,4),1),LAMBDA(r,CONCAT(r)))," ",""),
        result,REDUCE(startingstacks,A11:A513,LAMBDA(stacks,moves,
            LET(loc,{"move","from","to"},plus,{5,5,3},
            moveints,VALUE(MID(moves,FIND(loc,moves)+plus,{2,1,1})),
            move,INDEX(moveints,,1),from,INDEX(moveints,,2),to,INDEX(moveints,,3),pop,LEFT(INDEX(stacks,,from),move),
            IF(SEQUENCE(,9)=to,pop&stacks,IF(SEQUENCE(,9)=from,RIGHT(stacks,LEN(stacks)-move),stacks))))),
        CONCAT(LEFT(result,1)))

Part 1:

Backwards, I know. Part 1 should be as simple as reversing string in the "pop" variable. I've tried every way possible, and it makes an error. It seems you can't have CONCAT or any recursively defined functions inside a REDUCE-LAMBDA. Breaking the above apart, Part 1 can be solved by entering the following formulas. Note, the first one is a named-range LAMBDA.

    reverse =LAMBDA(txt,IF(txt="","",reverse(RIGHT(txt,LEN(txt)-1))&LEFT(txt,1)))
    F10 =SUBSTITUTE(BYCOL(MID(A1:A8,SEQUENCE(,9,2,4),1),LAMBDA(r,CONCAT(r)))," ","")
    C11 =LET(moves,A11:A513,loc,{"move","from","to"},plus,{5,5,3},VALUE(MID(moves,FIND(loc,moves)+plus,{2,1,1})))
    F11 =reverse(LEFT(OFFSET(F10,,D11),C11))
    G11 =LET(stacks,G10:O10,IF(SEQUENCE(,9)=E11,F11&stacks,IF(SEQUENCE(,9)=D11,RIGHT(stacks,LEN(stacks)-C11),stacks)))
    P9 =CONCAT(LEFT(G513:O513,1))
    
Drag or copy down F11 and G11 to the bottom, row 513. The solution to Part 1 is found with the formula in P9.
