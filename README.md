# AoC.2022

Advent of Code 2022

I'm going to try to use Excel this year. First with [LAMBDA and helpers](https://techcommunity.microsoft.com/t5/excel-blog/announcing-lambda-helper-functions-lambdas-as-arguments-and-more/ba-p/2576648), then maybe [VBA](https://learn.microsoft.com/en-us/office/vba/api/overview/excel) or [Office Scripts](https://learn.microsoft.com/en-us/office/dev/scripts/overview/excel) if needed. If I manage to refactor and solve Part 1 and 2 with a single formula, I'll put it here.

Day 1:

    =LET(blankrows,FILTER(ROW(A1:A2238),ISBLANK(A1:A2238)),
        lengths,TAKE(blankrows-VSTACK({0},blankrows),COUNT(blankrows))-1,
        offsets,blankrows-lengths-1,
        sums,MAP(offsets,lengths,LAMBDA(OFS,HT,
            SUM(OFFSET(A1,OFS,,HT)))),
        VSTACK(MAX(sums),SUM(LARGE(sums,{3,2,1}))))

Day 2:

    =LET(input,A1:A2500,
        part1,SWITCH(input,"A X",4,"A Y",8,"A Z",3,"B X",1,"B Y",5,"B Z",9,"C X",7,"C Y",2,"C Z",6),
        part2,SWITCH(input,"A X",3,"A Y",4,"A Z",8,"B X",1,"B Y",5,"B Z",9,"C X",2,"C Y",6,"C Z",7),
        VSTACK(SUM(part1),SUM(part2)))

Day 3:

    =LET(input,A1:A300,
        chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        matches,LAMBDA(one,two,CONCAT(IFERROR(MID(two,FIND(chars(one),two),1),""))),
        pos,CODE(MAP(LEFT(input,LEN(input)/2),RIGHT(input,LEN(input)/2),LAMBDA(a,b,matches(a,b)))),
        groups,CODE(BYROW(WRAPROWS(input,3),LAMBDA(r,
            matches(matches(INDEX(r,1),INDEX(r,2)),INDEX(r,3))))),
        score,LAMBDA(p,SUM(IF(p>96,p-96,p-38))),
        VSTACK(score(pos),score(groups)))
