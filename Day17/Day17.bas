Attribute VB_Name = "Day17"
Public rk As Rock
Public ct As Integer

Sub aoc22d17()
    Application.ScreenUpdating = False
    ct = 0
    i = 0
    Names.Add "board", [B:H]
    [board].ColumnWidth = 2
    Names.Add "rightEdge", [board].Columns(7).Offset(0, 1)
    Names.Add "leftEdge", [board].Columns(1).Offset(0, -1)
    Names.Add "bottom", [A1].End(xlDown).Offset(0, 1).Resize(1, 7)
    [bottom] = "X"
    
    gasJets = [A1]
    leng = Len(gasJets)
    
    newPiece
    Do While ct <= 2023
        If Mid(gasJets, i Mod leng + 1, 1) = ">" Then
            rk.MoveR
        Else
            rk.MoveL
        End If
        i = i + 1
        If Not rk.MoveD Then
            rk.rng.Value = rk.name
            newPiece
        End If
    Loop
    Application.ScreenUpdating = True
End Sub

Sub newPiece()
    Set rk = New Rock
    rk.setPiece ct
    ct = ct + 1
    mn = Cells(1048576, 2).CurrentRegion.Row
    With Cells(mn, 10).End(xlUp).Offset(1)
        .Value = ct - 1
        .Offset(0, 1) = 1048576 - mn
    End With
    rk.place Cells(mn - 7, 4)
End Sub

Sub part2()
    'After Rock #455 a repeating pattern emerges. Evey 2620 blocks thereafter produces 1710 rows.
    Dim rocks As LongLong
    Dim rows As LongLong
    Dim rounds As LongLong
    
    rocks = 1000000000000#
    f = (rocks - 455) / 1710
    rounds = f
    rows = 750 + rounds * 2620 + 988
    'Debug.Print rocks - rounds * 1710 - 455
    Debug.Print rows
End Sub

Function RangeDiff(rng1 As Range, rng2 As Range) As Range
    For Each c In rng2.Cells
        If Intersect(rng1, c) Is Nothing Then Set RangeDiff = Union2(RangeDiff, c)
    Next c
End Function

Function Union2(ParamArray Ranges() As Variant) As Range
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Union2
' A Union operation that accepts parameters that are Nothing.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    Dim N As Long
    Dim RR As Range
    For N = LBound(Ranges) To UBound(Ranges)
        If IsObject(Ranges(N)) Then
            If Not Ranges(N) Is Nothing Then
                If TypeOf Ranges(N) Is Excel.Range Then
                    If Not RR Is Nothing Then
                        Set RR = Application.Union(RR, Ranges(N))
                    Else
                        Set RR = Ranges(N)
                    End If
                End If
            End If
        End If
    Next N
    Set Union2 = RR
End Function
