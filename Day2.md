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


Or better yet, one formula for both Part 1 and 2, inspired by and copied from [this solution](https://github.com/judifer/aoc_2022/blob/main/day02.py):

    =LET(input,A1:A2500,
        part1,SWITCH(input,"A X",4,"A Y",8,"A Z",3,"B X",1,"B Y",5,"B Z",9,"C X",7,"C Y",2,"C Z",6),
        part2,SWITCH(input,"A X",3,"A Y",4,"A Z",8,"B X",1,"B Y",5,"B Z",9,"C X",2,"C Y",6,"C Z",7),
        VSTACK(SUM(part1),SUM(part2)))
