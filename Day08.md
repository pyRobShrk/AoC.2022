# Day 8

00:16:51   2329

15:03:57  49582

This one is a bit trickier in Excel. The data can't be simply pasted in A1 because it will convert to Double precision float numbers which removes leading zeros and lots of precision.
Instead I pasted the data into the *Formula bar* of Cell A1, so that the entire input is in cell A1 as text. Then it can be parsed, and a formula can be written to solve each Part.

    chars =LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1))
    C1 =INT(WRAPROWS(chars(A1),100))

If you don't know what that means, you'd create a named range using the Name Manager called chars, and it equals that lambda.
Then in Cell C1 put that formula, which spills out to C1:CW100. Now Cell C103 can get this formula:

    =1*OR(C3>MAX($B3:B3),C3>MAX(C$2:C2),C3>MAX(C4:C$100),C3>MAX(D3:$CV3))
    
Which then gets copied/dragged down to CU199. Another way to apply this same formula to all the cells is with VBA:

    [C103:CU199].Formula2R1C1 =  "=1*OR(R[-100]C>MAX(R[-100]C2:R[-100]C[-1]),R[-100]C>MAX(R2C:R[-101]C),R[-100]C>MAX(R[-99]C:R100C),R[-100]C>MAX(R[-100]C[1]:R[-100]C100))"
    
Either way, the answer for Part 1 is calculated by the sum of visible cells, here marked with a 1 (excluding the border, which is all visible).

    =SUM(C103:CU199)+98*4

Now Part 2 was a little bit harder to calculate. I put the following formula in C203:

    =LET(sightDist,LAMBDA(val,rng,asc,
        LET(d,XMATCH(SEQUENCE(,10-val,9,-1),rng,1,asc),mx,COUNT(rng),
            IF(asc=1,MIN(IFERROR(d,mx)),mx-MAX(IFERROR(d,1))+1))),
    sightDist(C3,D3:$CV3,1)*sightDist(C3,C4:C$100,1)*sightDist(C3,C$2:C2,-1)*sightDist(C3,$B3:B3,-1))

And that needs to be dragged/copied to CU300. Then the answer to Part 2 is easy enough to calculate with:

    =MAX(C203:CU300)
    
This problem does not lend itself well to Excel's LAMBDA helper functions, because it would be very difficult to do dynamic ranges that go from the middle to the edge.
I suppose it's possible using [MAKEARRAY](https://support.microsoft.com/en-us/office/makearray-function-b80da5ad-b338-4149-a523-5b221da09097), but it won't be pretty. Okay, here it goes:

    =LET(chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        forest,INT(WRAPROWS(chars(A1),100)),
        visTrees,MAKEARRAY(97,97,LAMBDA(r,c,
            LET(cl,INDEX(forest,r+1,c+1),
            up,INDEX(forest,SEQUENCE(r),c+1),down,INDEX(forest,SEQUENCE(98-r,,r+2),c+1),
            left,INDEX(forest,r+1,SEQUENCE(,c)),right,INDEX(forest,r+1,SEQUENCE(,98-c,c+2)),
           1*OR(cl>MAX(up),cl>MAX(down),cl>MAX(right),cl>MAX(left))))),
        SUM(visTrees)+98*4)

    =LET(chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        forest,INT(WRAPROWS(chars(A1),100)),
        sightDist,LAMBDA(val,rng,asc,
            LET(d,XMATCH(SEQUENCE(,10-val,9,-1),rng,1,asc),mx,COUNT(rng),IF(asc=1,MIN(IFERROR(d,mx)),mx-MAX(IFERROR(d,1))+1))),
        treeScore,MAKEARRAY(97,97,LAMBDA(r,c,
            LET(cl,INDEX(forest,r+1,c+1),
            up,INDEX(forest,SEQUENCE(r),c+1),down,INDEX(forest,SEQUENCE(98-r,,r+2),c+1),
            left,INDEX(forest,r+1,SEQUENCE(,c)),right,INDEX(forest,r+1,SEQUENCE(,98-c,c+2)),
            PRODUCT(sightDist(cl,right,1),sightDist(cl,down,1),sightDist(cl,left,-1),sightDist(cl,up,-1))))),
        MAX(treeScore))

Cool, so why not put it all in one cell. Sure why not:

    =LET(chars,LAMBDA(str,MID(str,SEQUENCE(LEN(str)),1)),
        forest,INT(WRAPROWS(chars(A1),100)),
        sightDist,LAMBDA(val,rng,asc,
            LET(d,XMATCH(SEQUENCE(,10-val,9,-1),rng,1,asc),mx,COUNT(rng),IF(asc=1,MIN(IFERROR(d,mx)),mx-MAX(IFERROR(d,1))+1))),
        visTrees,MAKEARRAY(97,97,LAMBDA(r,c,
            LET(cl,INDEX(forest,r+1,c+1),
            up,INDEX(forest,SEQUENCE(r),c+1),down,INDEX(forest,SEQUENCE(98-r,,r+2),c+1),
            left,INDEX(forest,r+1,SEQUENCE(,c)),right,INDEX(forest,r+1,SEQUENCE(,98-c,c+2)),
            score,PRODUCT(sightDist(cl,right,1),sightDist(cl,down,1),sightDist(cl,left,-1),sightDist(cl,up,-1)),
            score*IF(OR(cl>MAX(up),cl>MAX(down),cl>MAX(right),cl>MAX(left)),1,-1)))),
        VSTACK(SUM(1*(visTrees>0))+98*4,MAX(ABS(visTrees))))
