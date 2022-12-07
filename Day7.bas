Sub aoc22d7()
    Dim dirs As New Collection
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set here = fso.GetFolder(ThisWorkbook.Path).SubFolders.Add("aoc22d7")
    dirs.Add here
    
    For Each l In [A1].CurrentRegion.Cells
        If l.Value Like "$ cd [a-z]*" Then
            sep = InStr(3, l.Value, " ")
            d = Right(l.Value, Len(l.Value) - sep)
            Set here = here.SubFolders.Add(d)
            dirs.Add here
        ElseIf l.Value = "$ cd .." Then
            Set here = here.ParentFolder
        ElseIf l.Value Like "[1-9]*" Then
            sep = InStr(l.Value, " ")
            fn = Right(l.Value, Len(l.Value) - sep)
            sz = Int(Left(l.Value, sep))
            Set f = here.CreateTextFile(fn)
                f.WriteBlankLines Int(sz / 2)
                If sz Mod 2 Then f.Write ("a")
                f.Close
        End If
    Next l
    
    fSum = 0
    For Each d In dirs
        With [C999].End(xlUp).Offset(1)
            .Value = d.Path
            .Offset(0, 1).Value = d.Size
        End With
        If d.Size <= 100000 Then fSum = fSum + d.Size
    Next d
    Debug.Print fSum 'Part 1, Part 2 calculated from output
    
End Sub
