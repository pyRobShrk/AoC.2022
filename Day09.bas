Sub aoc22d9()
    [A1].CurrentRegion.Offset(0, 1).Formula2R1C1 = "=TEXTSPLIT(RC[-1],"" "")"
    Names.Add "d9input", Range([B1], [C1].End(xlDown))
    Set head = Range("ZZ999")
    Set Tail = Range("ZZ999")

    For Each r In [d9input].Rows
        d = r.Cells(1)
        n = r.Cells(2)
        For Move = 1 To n
            Select Case d
                Case "R"
                    Set head = head.Offset(0, 1)
                Case "L"
                    Set head = head.Offset(0, -1)
                Case "U"
                    Set head = head.Offset(-1, 0)
                Case "D"
                    Set head = head.Offset(1, 0)
            End Select
            
            Set rope = Range(head, Tail)
            Select Case rope.Cells.Count
                Case 1, 2, 4 'Overlap or touching
                Case 3 'One row or column
                    Set Tail = rope.Cells(2)
                Case 6 'Diagonal
                    If head.Row > Tail.Row Then
                        If head.Column > Tail.Column Then
                            Set Tail = Tail.Offset(1, 1)
                        Else
                            Set Tail = Tail.Offset(1, -1)
                        End If
                    Else
                        If head.Column > Tail.Column Then
                            Set Tail = Tail.Offset(-1, 1)
                        Else
                            Set Tail = Tail.Offset(-1, -1)
                        End If
                    End If
            End Select
            Tail.Value = 1
        Next Move
    Next r
    Debug.Print WorksheetFunction.Sum(Tail.CurrentRegion)
End Sub

Sub aoc22d9p2()
    Application.ScreenUpdating = False
    Set head = Range("MZZ9999")
    For i = 1 To 9
        Names.Add "knot" & CStr(i), head, False
    Next i

    For Each r In [d9input].Rows
        d = r.Cells(1)
        n = r.Cells(2)
        For Move = 1 To n
            Select Case d
                Case "R"
                    Set head = head.Offset(0, 1)
                Case "L"
                    Set head = head.Offset(0, -1)
                Case "U"
                    Set head = head.Offset(-1, 0)
                Case "D"
                    Set head = head.Offset(1, 0)
            End Select
            
            Set knot = head
            For i = 1 To 9
                Set Tail = Evaluate("knot" & i)
                Set rope = Range(knot, Tail)
                Select Case rope.Count
                    Case 1, 2, 4 'Overlap or touching
                    Case 3 'One row or column
                        Set Tail = rope.Cells(2)
                    Case Else
                        If knot.Row > Tail.Row Then
                            If knot.Column > Tail.Column Then
                                Set Tail = Tail.Offset(1, 1)
                            Else
                                Set Tail = Tail.Offset(1, -1)
                            End If
                        Else
                            If knot.Column > Tail.Column Then
                                Set Tail = Tail.Offset(-1, 1)
                            Else
                                Set Tail = Tail.Offset(-1, -1)
                            End If
                        End If
                End Select
                
                Names("knot" & i).RefersTo = Tail
                Set knot = Tail
            Next i
            Tail.Value = 1
        Next Move
    Next r
    Debug.Print WorksheetFunction.Sum(Tail.CurrentRegion)
End Sub
