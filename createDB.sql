USE [Data warehouse]
GO
/****************** Créer Table [dbo].[D_Date] ********************/
CREATE TABLE [dbo].[D_Date](
[Date] [datetime] NOT NULL,
[Year] AS (datepart(year,[Date])),
[Semester] AS (CONVERT([varchar](4),datepart(year,[Date]),(0))+case when
datepart(month,[Date])>(6) then '2' else '1' end),
[Quarter] AS
(CONVERT([varchar](4),datepart(year,[Date]),(0))+datename(quarter,[Date])),
[Month] AS (datepart(month,[Date])),
[Month_Name] AS
(upper(substring(datename(month,[Date]),(1),(1)))+substring(datename(month,[Date]),(2)
,len(datename(month,[Date])))),
[Week] AS ((CONVERT([varchar](4),datepart(year,[Date]),(0))+replicate('0',(2)-
len(datepart(week,[Date]))))+CONVERT([nvarchar](2),datepart(week,[Date]),(0))),
[Day] AS (datepart(day,[Date])),
[Day_of_Week] AS (datename(weekday,[Date])),
[Day_of_Year] AS (datename(dayofyear,[Date])),
[Jour_Ferie] [char](3) NULL,
[FiscalWeek] [int] NULL,
CONSTRAINT [PK_D_Date] PRIMARY KEY CLUSTERED
(
[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/************************ Remplir la table D_Date***************************/

declare @d date
set @d='2005-01-01'
while @d<='2018-12-31'
begin
--select @d
insert into D_Date(Date) values (@d)
set @d=dateadd(dd,1,@d)
end