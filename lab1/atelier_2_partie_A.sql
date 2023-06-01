Use [Data warehouse]
/*Création des tables de chargement, une base de chargement peut être utilisée*/
CREATE TABLE [D_Customer_STA](
[ID_Customer] [int] NULL,
[CustomerIDSource] [int] NULL,
[FirstName] [nvarchar](50) NULL,
[LastName] [nvarchar](50) NULL,
[AccountNumber] [nvarchar](10) NULL,
Title nvarchar(8) NULL
)
CREATE TABLE [F_SALES_STA](
[CustomerID] [int] NOT NULL,
[Date] [datetime] NOT NULL,
[ID_Customer] [int] NULL,
[SubTotal] [money] NULL,
[TaxAmt] [money] NULL,
[Freight] [money] NULL
)
/****Création de la table de dimension et table de fait*****/
CREATE TABLE [dbo].[D_Customer](
[ID_Customer] [int] IDENTITY(1,1) NOT NULL,
[CustomerIDSource] [int] NULL,
[FirstName] [nvarchar](50) NULL,
[LastName] [nvarchar](50) NULL,
[AccountNumber] [nvarchar](10) NULL,
Title nvarchar(8)
CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED
(
[ID_Customer] ASC
)
) ON [PRIMARY]
CREATE TABLE [F_SALES] (
[Date] [datetime] NOT NULL,
[ID_Customer] [int] NOT NULL,
[SubTotal] [money] NULL,
[TaxAmt] [money] NULL,
[Freight] [money] NULL,
[Total] [money] NULL,
CONSTRAINT [PK_F_SALES] PRIMARY KEY
(
[Date] ASC,
[ID_Customer] ASC
) ON [PRIMARY])