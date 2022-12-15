## Day 15

Part 1:

    =LET(in,A1:A23,comma1,FIND(",",in,13),colon,FIND(":",in),beaconX,FIND("x=",in,colon),beaconY,FIND("y=",in,colon),
        Sx,VALUE(MID(in,13,comma1-13)),    Sy,VALUE(MID(in,comma1+4,colon-comma1-4)),
        Bx,VALUE(MID(in,beaconX+2,beaconY-beaconX-4)),    By,VALUE(RIGHT(in,LEN(in)-beaconY-1)),
        mDist,ABS(By-Sy)+ABS(Bx-Sx),    d,ABS(Sy-2000000),    c,mDist-d,ln,2*(c+1)-1,
        ranges,IF(ln>0,HSTACK(Sx-c,Sx-c+ln),""),    MAX(ranges)-MIN(ranges)-1)
