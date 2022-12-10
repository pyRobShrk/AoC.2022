# Day 1

00:07:26  4163

00:09:14  3371

* I copied and pasted the data into Excel. After staring for a few seconds, there was no good way to sum each group.
* I pasted the data into Notepad++
* With a few find/replaces, the data was re-formatted such that each group was a row separated by commas, with newlines in between
* I pasted the manipulated data into Excel
* Ctrl+A revealed that the right-most column used was column O
* In Column Q, formula =SUM(A1:O1)
* Copied down to Q235, Part 1 answer (maximum) revealed in status bar
* Part 2: =SUM(LARGE(Q1:Q235,{1,2,3}))

A more elegant VBA solution has occured to me:

    Sub aoc22d1()
        [A1].Select
        ActiveSheet.Paste
        For Each a In [A:A].SpecialCells(xlCellTypeConstants).Areas
            [C999].End(xlUp).Offset(1) = WorksheetFunction.Sum(a)
        Next a
        Set sums = [C2].CurrentRegion
        With WorksheetFunction
            [E1] = .Max(sums)
            [E2] = .Sum([E1], .Large(sums, 2), .Large(sums, 3))
        End With
    End Sub

Finally, I have a pure Excel formula solution that doesn't require pre-manipulation of the input.
Paste input in A1.

    C1 =FILTER(ROW(A1:A2238),ISBLANK(A1:A2238))
    D1 =TAKE(C1#-VSTACK({0},C1#),COUNT(C1#))-1
    E1 =C1#-D1#-1
    F1 =SUM(OFFSET($A$1,E1,,D1))
    Double click F1 to fill down
    G1 =MAX(F1:F235)
    G2 =SUM(LARGE(F1:F235,{1,2,3}))
    
This could all be in a single LAMBDA, except that the OFFSET function doesn't support array inputs for row and height...

And finally, almost 24 hours later, I have solved the puzzle with just ONE formula:

    =LET(blankrows,FILTER(ROW(A1:A2238),ISBLANK(A1:A2238)),
        lengths,TAKE(blankrows-VSTACK({0},blankrows),COUNT(blankrows))-1,
        offsets,blankrows-lengths-1,
        sums,MAP(offsets,lengths,LAMBDA(OFS,HT,
            SUM(OFFSET(A1,OFS,,HT)))),
        VSTACK(MAX(sums),SUM(LARGE(sums,{3,2,1}))))

