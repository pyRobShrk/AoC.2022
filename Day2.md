# Day 2
100% Excel Formulas

00:22:32  9144

00:48:22  12329

Part 1:

    =LET(input,A1:A2500,
        op,CODE(LEFT(input,1)),
        me,CODE(RIGHT(input,1))-23,
        result,me-op,
        SUM(BYROW(result,LAMBDA(r,IF(OR(r=1,r=-2),6,IF(r=0,3,0))))+me-64))
        
Part 2:

    =LET(input,A1:A2500,
        op,CODE(LEFT(input,1))-64,
        outcome,RIGHT(input,1),
        score,BYROW(HSTACK(op,outcome),LAMBDA(r,
            LET(rps,INDEX(r,1),SWITCH(INDEX(r,2),"Y",3+rps,"X",SWITCH(rps,1,3,2,1,3,2),"Z",6+MOD(rps,3)+1)))),
        SUM(score))
