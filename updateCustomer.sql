UPDATE [dbo].[D_Customer]
SET [FirstName] = STA.FirstName
,[LastName] = STA.LastName
,[AccountNumber] = STA.AccountNumber,
,Title=STA.Title
FROM D_Customer_STA as STA
WHERE [D_Customer].ID_Customer=STA.ID_Customer