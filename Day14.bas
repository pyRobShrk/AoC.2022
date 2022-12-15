Sub aoc22d14_walls()
    For Each wall In [A1].CurrentRegion.Cells
        Corners = Split(wall, "->")
        For c = 1 To UBound(Corners)
            cr0 = Split(Corners(c - 1), ",")
            cr1 = Split(Corners(c), ",")
            Range(Cells(Int(cr0(1)) + 1, Int(cr0(0))), _
                  Cells(Int(cr1(1)) + 1, Int(cr1(0)))) = "X"
        Next c
    Next wall
End Sub

Sub aoc22d14_sand()
    Set grain = Cells(500)
    Do
        Set grain = grain.End(xlDown).Offset(-1)
        If Not (grain.Offset(1, -1) = "" Or _
                grain.Offset(1, 0) = "" Or _
                grain.Offset(1, 1) = "") Then
            grain.Value = "o"
            Set grain = Cells(500)
        ElseIf grain.Offset(1, -1) = "" Then
            Set grain = grain.Offset(1, -1)
        ElseIf grain.Offset(1, 1) = "" Then
            Set grain = grain.Offset(1, 1)
        End If
    Loop While grain.Row < 200 And Cells(500) = ""
End Sub

Sub aoc22d14_part2()
    Application.ScreenUpdating = False
    Cells(161, 1).Resize(1, 999) = "X"
    aoc22d14_sand
    Application.ScreenUpdating = True
    Debug.Print WorksheetFunction.CountIf(Cells(500).CurrentRegion, "o")
End Sub
