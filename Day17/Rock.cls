VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Rock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Base 0

Public name As String
Public rng As Range
Private loc As Range
Private addrs As Variant

Public Sub setPiece(ct As Integer)
    name = WorksheetFunction.Choose(ct Mod 5 + 1, "-", "+", "J", "I", "O")
    Select Case name
        Case "J"
            addrs = "A4:C4,C2:C3"
        Case "+"
            addrs = "A3:C3,B2,B4"
        Case "O"
            addrs = "A3:B4"
        Case "I"
            addrs = "A1:A4"
        Case "-"
            addrs = "A4:D4"
    End Select
    Set rng = [board].Range(addrs)
End Sub

Public Sub place(rn As Range)
        Set loc = rn
        Set rng = loc.Range(addrs)
End Sub

Public Sub MoveR()
    If Intersect([rightEdge], loc.Offset(0, 1).Range(addrs)) Is Nothing Then
        For Each c In RangeDiff(rng, loc.Offset(0, 1).Range(addrs)).Cells
            If Not c.Value = "" Then Exit Sub
        Next c
        Me.place loc.Offset(0, 1)
    End If
End Sub

Public Sub MoveL()
    If Intersect([leftEdge], loc.Offset(0, -1).Range(addrs)) Is Nothing Then
        For Each c In RangeDiff(rng, loc.Offset(0, -1).Range(addrs)).Cells
            If Not c.Value = "" Then Exit Sub
        Next c
        Me.place loc.Offset(0, -1)
    End If
End Sub

Public Function MoveD() As Boolean
    If Intersect([bottom], loc.Offset(1, 0).Range(addrs)) Is Nothing Then
        For Each c In RangeDiff(rng, loc.Offset(1, 0).Range(addrs)).Cells
            If Not c.Value = "" Then Exit Function
        Next c
        Me.place loc.Offset(1, 0)
        MoveD = True
    End If
End Function
