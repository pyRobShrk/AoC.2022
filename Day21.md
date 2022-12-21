# Day 21

12:09:30  14437

12:14:13  11169

Today was pretty straight-forward in Excel, but I'm not sure it can be golfed into a single formula.
Perhaps with a recursive LAMBDA to evaluate the math. I'm not up to it. Here's my solution with input pasted in A1:

    B1 =TEXTBEFORE(A1:A2597,":")
    C1 =TEXTAFTER(A1:A2597,": ")
    D1 =IFERROR(VALUE(C1),TEXTSPLIT(C1," "))
    G1 =IF(ISNUMBER(D1),D1,LET(
        first,XLOOKUP(D1,$B$1:$B$2597,$G$1:$G$2597),
        second,XLOOKUP(F1,$B$1:$B$2597,$G$1:$G$2597),
        SWITCH(E1,"+",first+second,"-",first-second,"*",first*second,"/",first/second)))

Now D1 and G1 need to be dragged/copied down to row 2597, but that's it.
G1 appears to be a circular reference, but the lookups never self-refer so it's not.
For Part 1, I just had to find root. For Part 2, I used Goal Seek.
