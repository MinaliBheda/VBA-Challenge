Attribute VB_Name = "Module1"
Sub MultipleYearStock()

Dim no_of_rows As Double
Dim ticker As String
Dim yearly_chg As Double
Dim percent_chg As Double
Dim totalvol As Double
Dim i As Double
Dim volume As Double
Dim open_value As Double
Dim close_value As Double
Dim newrow As Double
Dim firstvalue As Double
Dim nextvalue As Double
Dim max_perchng As Double
Dim min_perchng As Double
Dim max_totalvol As Double
Dim ticker_max As String
Dim ticker_min As String


'Create New Columns

Cells(1, 9).Value = "Ticker"
Cells(1, 10).Value = "Yearly Change"
Cells(1, 11).Value = "Percent Change"
Cells(1, 12).Value = "Total Stock Volume"

'Count total no of rows
no_of_rows = Range("A1").End(xlDown).Row

'Initialisation
ticker = Cells(2, 1).Value
open_value = Cells(2, 3).Value
newrow = 2


For i = 2 To no_of_rows
    
    ticker = Cells(i, 1).Value
    
   ' Searches for when the value of the next cell is different than that of the current cell
    If Cells(i + 1, 1).Value <> ticker Then
        
        'Calculating Yearly Change and Percent Change
        close_value = Cells(i, 6).Value
        yearly_chg = close_value - open_value
        percent_chg = yearly_chg / open_value
        
        volume = Cells(i, 7).Value
        totalvol = totalvol + volume
        
        Cells(newrow, 9).Value = ticker
        Cells(newrow, 10).Value = yearly_chg
        'Conditional Formatting for Column Percent Change
        Cells(newrow, 11).Value = FormatPercent(percent_chg, 2)
        Cells(newrow, 12).Value = totalvol
        
        'Conditional formatting that will highlight positive change in green and negative change in red.
        If ((Sgn(yearly_chg) = 1) Or (Sgn(yearly_chg) = 0)) Then
            Cells(newrow, 10).Interior.ColorIndex = 4
        ElseIf (Sgn(yearly_chg) = -1) Then
            Cells(newrow, 10).Interior.ColorIndex = 3
        End If
        
        open_value = Cells(i + 1, 3).Value
        newrow = newrow + 1
        totalvol = 0
        
    Else
        'Calculating Total Stock Volume per Ticker
        volume = Cells(i, 7).Value
        totalvol = totalvol + volume
        

End If


Next i

'Add new columns
Cells(1, 15).Value = "Ticker"
Cells(1, 16).Value = "Value"

Cells(2, 14).Value = "Greatest % increase"
Cells(3, 14).Value = "Greatest % decrease"
Cells(4, 14).Value = "Greatest total volume"

i = 2
'Total number of Yearly Change Rows
no_of_rows = Range("K1").End(xlDown).Row
ticker = ""
max_perchng = Cells(2, 11).Value
min_perchng = Cells(2, 11).Value
    
For i = 2 To no_of_rows
    
    firstvalue = Cells(i, 11).Value
    nextvalue = Cells(i + 1, 11).Value
    
    'Greatest% increase
    If (firstvalue > nextvalue And firstvalue >= max_perchng) Then
        max_perchng = firstvalue
        ticker_max = Cells(i, 9).Value
    ElseIf (max_perchng < nextvalue) Then
        max_perchng = nextvalue
        ticker_max = Cells(i + 1, 9).Value
    End If
    
    'Greatest% decrease
    If (firstvalue < nextvalue And firstvalue <= min_perchng) Then
        min_perchng = firstvalue
        ticker_min = Cells(i, 9).Value
    ElseIf (min_perchng > nextvalue) Then
        min_perchng = nextvalue
        ticker_min = Cells(i + 1, 9).Value
    End If
    
    'Greatest Total Volume
    If (Cells(i, 12).Value > Cells(i + 1, 12).Value And Cells(i, 12).Value >= max_totalvol) Then
        max_totalvol = Cells(i, 12).Value
        ticker = Cells(i, 9).Value
    ElseIf (max_totalvol < Cells(i + 1, 12).Value) Then
        max_totalvol = Cells(i + 1, 12).Value
        ticker = Cells(i + 1, 9).Value
    End If
    
Next i
    
Cells(2, 15).Value = ticker_max
Cells(3, 15).Value = ticker_min
Cells(4, 15).Value = ticker

'Conditional Formatting for Cells Max and Min Percent Change
Cells(2, 16).Value = FormatPercent(max_perchng, 2)
Cells(3, 16).Value = FormatPercent(min_perchng, 2)
Cells(4, 16).Value = max_totalvol


End Sub
