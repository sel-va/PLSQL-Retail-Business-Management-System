/*-----------------------------------------------------------------------------------------------------
	FILE: SP_NEW_PRD_INSERT_UPDATE_DELETE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN PROCEDURE 
	AUTHOR: SELVA
	DATE CREATED: 05/09/2019
*/-----------------------------------------------------------------------------------------------------

/*
The database will have the ability to add new products to the products table.
The database will have the ability to update existing products in the products table.
The database will have the ability to delete products from the products table.
The database will have the ability to generate reports on customer and order data.
*/

CREATE or REPLACE PROCEDURE SP_NEW_PRD (
	P_userip IN INTEGER,
    P_Prd_ID IN INTEGER,
	P_Product_Name IN VARCHAR,
	P_Product_Description IN VARCHAR,
	P_Product_Price IN DECIMAL,
	P_Product_Stock IN INTEGER
)
AS
lv_errcode varchar(100);
lv_errmsg varchar(30);

BEGIN
	
--1 MEANS INSERT
IF P_userip = 1 THEN 
	INSERT INTO Products 
	VALUES (
		seq_prd_id.nextval,
		P_Product_Name,
		P_Product_Description,
		P_Product_Price,
		P_Product_Stock
		);

ELSIF 
--2 MEANS UPDATE
P_userip = 2 THEN
	UPDATE Products 
	SET 
		Product_Name = P_Product_Name,
		Product_Description = P_Product_Description,
		Product_Price = P_Product_Price,
		Product_Stock = P_Product_Stock 
			WHERE Product_ID = P_prd_ID;

END IF;

COMMIT;

EXCEPTION
when others then

lv_errcode := SQLCODE;
lv_errmsg := substr(SQLERRM,1,30);

sp_Error_log(lv_errcode,lv_errmsg,'SP_NEW_PRD');

END;
/



CREATE or REPLACE PROCEDURE SP_DEL_PRD ( P_prd_ID IN INTEGER)
AS
lv_errcode varchar(100);
lv_errmsg varchar(30);

BEGIN
    DELETE FROM Products
			WHERE Product_ID = P_prd_ID;

COMMIT;

EXCEPTION
when others then
lv_errcode := SQLCODE;
lv_errmsg := substr(SQLERRM,1,30);

sp_Error_log(lv_errcode,lv_errmsg,'SP_PRD_ODR');

END;
/

