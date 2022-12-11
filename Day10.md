## Day 10

00:14:22   2244 

00:29:27   2127

It feels like today I spent more time reading and re-reading the problem than implementing the solution. But the complete example was helpful.
This formula is my solution to both parts.

    =LET(vals,IFERROR(VALUE(MID(A1:A146,5,5)),0),
        clock,SCAN(0.01,vals,LAMBDA(a,v,IF(v,a+2,a+1))),
        x,SCAN(1,vals,LAMBDA(a,v,a+v)),
        signal,{20,60,100,140,180,220}, strength,LOOKUP(signal,clock,x),
        grid,SEQUENCE(6,40), sprite,LOOKUP(grid,clock,x),
        VSTACK(SUM(signal*strength),1*(ABS(MOD(grid-1,40)-sprite)<2)))
        
After resizing the columns width to 2, and some conditional formatting:

![screenshot](/Day10.png)

You can see, the upper left corner of my screen is broken. It's trying to do LOOKUP on a zero, but the time stamps start at 1.
A catchable error, but it doesn't really change the outcome of the puzzle, so I'll leave it alone.
