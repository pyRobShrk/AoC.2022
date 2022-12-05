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
