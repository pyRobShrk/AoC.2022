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

A more elegant VBA solution has occured to me

    Sub aoc22d1()
        [A1].Paste
        For Each a in [A:A].Areas
            [C99].End(xlUp) = WorksheetFunction.Sum(a)
        Next a
        Set sums = [C1].CurrentRegion
        With WorksheetFunction
            [E1] = .Max(sums)
            [E2] = .Sum(.Large(sums,Array(1,2,3)))
        End With
        [E1] =
    End Sub