use AdventureWorks2012;

/* --- 1 --- */
select SalesOrderID, ShipDate
from Sales.SalesOrderHeader
where OrderDate between '7/28/2002' and '7/29/2014'



/* --- 2 --- */
select ProductID, Name
from Production.Product
where StandardCost <110




/* --- 3 --- */
select ProductID, Name
from Production . Product
where Weight is NULL




/* --- 4 --- */
select ProductID, Name
from Production.Product
where Color in('Black', 'Silver' , 'Red')



/* --- 5 --- */
select Name
from Production.Product
where Name like 'b%'



/* --- 6 --- */
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3 

select Description
from Production.ProductDescription
where Description like '%[_]%' --to show any description contains underscores in it.



/* --- 7 --- */
select OrderDate, SUM(TotalDue)  as 'Sum of Total Dues'
from Sales.SalesOrderHeader 
group by OrderDate 
having OrderDate between '7/1/2001' and '7/31/2014'



/* --- 8 --- */
select distinct HireDate
from HumanResources.Employee



/* --- 9 --- */
select avg(distinct ListPrice)
from Production.Product



/* --- 10 --- ???????????????? */
select Name, ListPrice
from Production.Product
where ListPrice between 100 and 120
order by ListPrice



/* --- 11 --- */

-- a -- 
--select [columns_selected] into [NewTable_Name]: takes a specific columns from any table and create a new table and put them in it
select SalesPersonID ,Name, rowguid, Demographics into Sales.Store_Archive
from Sales.Store 


--b --


/* --- 12 --- */

-- DATE ONLY FORMATS --
select convert(varchar, getdate(), 1)
	--output: 12/30/06 (mm/dd/yy)
	union
select convert(varchar, getdate(), 2)
	--output: 06.12.30 (yy.mm.dd)
	union
select convert(varchar, getdate(), 3)	
	--output: 30/12/06 (dd/mm/yy)
	union
select convert(varchar, getdate(), 4)	
	--output: 30.12.06 (dd.mm.yy)	
	union
select convert(varchar, getdate(), 5)
	--output: 30-12-06 (dd-mm-yy)
	union
select convert(varchar, getdate(), 6)	
	--output: 30 Dec 06 (dd-Mon-yy)
	union
select convert(varchar, getdate(), 7)	
	--output: Dec 30, 06 (Mon dd, yy)
	union
select convert(varchar, getdate(), 10)	
	--output: 12-30-06 (mm-dd-yy)
	union
select convert(varchar, getdate(), 11)
	--output: 06/12/30 (yy/mm/dd)
	union
select convert(varchar, getdate(), 12)
	--output: 061230 (yymmdd)
	union
select convert(varchar, getdate(), 23)
	--output: 2006-12-30 (yyyy-mm-dd)
	union
select convert(varchar, getdate(), 101)
	--output: 12/30/2006 (mm/dd/yyyy)
	union
select convert(varchar, getdate(), 103)
	--output: 30/12/2006 (dd/mm/yyyy)
	union
select convert(varchar, getdate(), 104)
	--output: 30.12.2006 (dd.mm.yyyy)
	union
select convert(varchar, getdate(), 105)
	--output: 30-12-2006 (dd-mm-yyyy)
	union
select convert(varchar, getdate(), 106)
	--output: 30 Dec 2006 (dd Mon yyyy)
	union
select convert(varchar, getdate(), 107)
	--output: Dec 30, 2006 (Mon dd, yyyy)
	union
select convert(varchar, getdate(), 110)
	--output: 12-30-2006 (mm-dd-yyyy)
	union
select convert(varchar, getdate(), 111)	
	--output: 2006/12/30 (yyyy/mm/dd)
	union
select convert(varchar, getdate(), 112)
	--output : 20061230 (yyyymmdd)
 	

/* 

-- TIME ONLY FORMATS -- 
select convert(varchar, getdate(), 8);
	output: 00:38:54 (hh:mm:ss)
select convert(varchar, getdate(), 14);	
	output: 00:38:54:840 (hh:mm:ss:nnn)
select convert(varchar, getdate(), 24);	
	output: 00:38:54 (hh:mm:ss)
select convert(varchar, getdate(), 108);
	output: 00:38:54 (hh:mm:ss)
select convert(varchar, getdate(), 114);
	output: 00:38:54:840 (hh:mm:ss:nnn)
 	
---------------------------------------------------------------

-- DATE & TIME FORMATS --
select convert(varchar, getdate(), 0);	
	output: Dec 30 2006 12:38AM (Mon dd yyyy hh:mm AM/PM)
select convert(varchar, getdate(), 9);
	output: Dec 30 2006 12:38:54:840AM (Mon dd yyyy hh:mm:ss:nnn AM/PM)
select convert(varchar, getdate(), 13);
	output: 30 Dec 2006 00:38:54:840AM (dd Mon yyyy hh:mm:ss:nnn AM/PM)
select convert(varchar, getdate(), 20);	
	output: 2006-12-30 00:38:54 (yyyy-mm-dd hh:mm:ss)
select convert(varchar, getdate(), 21);	
	output: 2006-12-30 00:38:54.840 (yyyy-mm-dd hh:mm:ss:nnn)
select convert(varchar, getdate(), 22);	
	output: 12/30/06 12:38:54 AM (mm/dd/yy hh:mm:ss AM/PM)
select convert(varchar, getdate(), 25);
	output: 2006-12-30 00:38:54.840 (yyyy-mm-dd hh:mm:ss:nnn)
select convert(varchar, getdate(), 100);
	output: Dec 30 2006 12:38AM (Mon dd yyyy hh:mm AM/PM)
select convert(varchar, getdate(), 109);	
	output: Dec 30 2006 12:38:54:840AM (Mon dd yyyy hh:mm:ss:nnn AM/PM)
select convert(varchar, getdate(), 113);
	output: 30 Dec 2006 00:38:54:840 (dd Mon yyyy hh:mm:ss:nnn)
select convert(varchar, getdate(), 120);
	output: 2006-12-30 00:38:54 (yyyy-mm-dd hh:mm:ss)
select convert(varchar, getdate(), 121);
	output: 2006-12-30 00:38:54.840 (yyyy-mm-dd hh:mm:ss:nnn)
select convert(varchar, getdate(), 126);
	output: 2006-12-30T00:38:54.840 (yyyy-mm-dd T hh:mm:ss:nnn)
select convert(varchar, getdate(), 127);	
	output: 2006-12-30T00:38:54.840 (yyyy-mm-dd T hh:mm:ss:nnn	)

-------------------------------------------------------------
 	
-- ISLAMIC CALENDAR DATES --
select convert(nvarchar, getdate(), 130);
select convert(nvarchar, getdate(), 131);	
	output: 10/12/1427 12:38:54:840AM (dd mmm yyyy hh:mi:ss:nnn AM/PM)



select replace(convert(varchar, getdate(),101),'/','');
	output: 12302006 (mmddyyyy)
select replace(convert(varchar, getdate(),101),'/','') + replace(convert(varchar, getdate(),108),':','');	
	output: 12302006004426 (mmddyyyyhhmmss)
	
*/








