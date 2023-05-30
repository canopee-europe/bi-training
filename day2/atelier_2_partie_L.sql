Update F_SALES_STA
Set ID_Customer=u.ID_Customer
From D_Customer u
Where F_SALES_STA.CustomerID=u.CustomerIDSource