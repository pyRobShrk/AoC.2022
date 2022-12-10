# Day 4
00:08:35  3682
  
00:10:12   2555

Okay, so I didn't originally solve this one as a single formula. But the formulas that I used in multiple cells were very nearly the same.
The only real difference is that my answer was originally just by highlighting the boolean column and looking at the sum in the status bar.

    =LET(input,A1:A1000,c,FIND(",",input),
        rng,LAMBDA(s,HSTACK(VALUE(TEXTBEFORE(s,"-")),VALUE(TEXTAFTER(s,"-")))),
        data,HSTACK(rng(MID(input,1,c-1)),rng(MID(input,c+1,LEN(input)-c))),
        overlaps,BYROW(data,LAMBDA(rw,LET(a,INDEX(rw,1),b,INDEX(rw,2),c,INDEX(rw,3),d,INDEX(rw,4),
            1*OR(AND(c>=a,d<=b),AND(b<=d,a>=c))+1*NOT(OR(b<c,d<a))))),
        VSTACK(SUM(IF(overlaps=2,1)),SUM(IF(overlaps>0,1))))
