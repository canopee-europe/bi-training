UPDATE [dbo].[F_SALES]
SET
[SubTotal] = [F_SALES_STA].SubTotal
,[TaxAmt] = [F_SALES_STA].TaxAmt
,[Freight] = [F_SALES_STA].Freight
,[Total] = [F_SALES_STA].SubTotal+ [F_SALES_STA].TaxAmt+[F_SALES_STA].Freight
FROM [F_SALES_STA]
WHERE
[F_SALES].[Date] = [F_SALES_STA].date
and [F_SALES].[ID_Customer] = [F_SALES_STA].ID_Customer