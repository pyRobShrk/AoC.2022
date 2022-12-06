# AoC.2022

Advent of Code 2022

I'm going to try to use Excel this year. First with [LAMBDA and helpers](https://techcommunity.microsoft.com/t5/excel-blog/announcing-lambda-helper-functions-lambdas-as-arguments-and-more/ba-p/2576648), then maybe [VBA](https://learn.microsoft.com/en-us/office/vba/api/overview/excel) or [Office Scripts](https://learn.microsoft.com/en-us/office/dev/scripts/overview/excel) if needed. If I manage to refactor and solve Part 1 and 2 with a single formula, I'll put it here.

          -------Part 1--------   --------Part 2--------
    Day       Time  Rank  Score       Time   Rank  Score
      6   00:05:12  2177      0   00:06:31   2157      0
      5   00:20:42  2947      0   00:21:51   2246      0
      4   00:08:35  3682      0   00:10:12   2555      0
      3   00:08:28  2036      0   00:36:03   8055      0
      2   00:22:32  9144      0   00:48:22  12329      0
      1   00:07:26  4163      0   00:09:14   3371      0

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

Day 4:

    =LET(input,A1:A1000,c,FIND(",",input),
        rng,LAMBDA(s,HSTACK(VALUE(TEXTBEFORE(s,"-")),VALUE(TEXTAFTER(s,"-")))),
        data,HSTACK(rng(MID(input,1,c-1)),rng(MID(input,c+1,LEN(input)-c))),
        overlaps,BYROW(data,LAMBDA(rw,LET(a,INDEX(rw,1),b,INDEX(rw,2),c,INDEX(rw,3),d,INDEX(rw,4),
            1*OR(AND(c>=a,d<=b),AND(b<=d,a>=c))+1*NOT(OR(b<c,d<a))))),
        VSTACK(SUM(IF(overlaps=2,1)),SUM(IF(overlaps>0,1))))
