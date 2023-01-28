/*-----------------------------------------------------------------------------------------------------
	FILE: SP_NEW_PRD_INSERT_UPDATE_DELETE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN STORED PROCEDURE FOR ORDER
	AUTHOR: SELVA
	DATE CREATED: 05/09/2019
*/-----------------------------------------------------------------------------------------------------

/*
The database will have the ability to add new products to the products table.
The database will have the ability to update existing products in the products table.
The database will have the ability to delete products from the products table.
The database will have the ability to generate reports on customer and order data.
*/


CREATE or REPLACE PROCEDURE SP_NEW_ODR (
P_userip IN INTEGER,
P_Order_ID IN NUMBER,
P_Customer_ID IN INTEGER,
P_Order_Date IN DATE,
P_Product_ID IN INTEGER,
P_Total_Amount IN DECIMAL)
AS
lv_errcode varchar(100);
lv_errmsg varchar(30);

product_prc DECIMAL(10,2);

BEGIN
    SELECT PRODUCT_PRICE 
	INTO product_prc
    FROM products
    WHERE Product_ID = P_Product_ID;
	
	
--1 MEANS INSERT
IF P_userip = 1 THEN 

	INSERT INTO Orders 
	VALUES (
		seq_odr_id.nextval,
		P_Customer_ID,
		SYSDATE,
		P_Product_ID,
		product_prc);

ELSIF 
--2 MEANS UPDATE
P_userip = 2 THEN
	UPDATE Orders 
	SET 
		Order_Date = P_Order_Date,
		Product_ID = P_Product_ID,
		Total_Amount = P_Total_Amount
		WHERE Order_ID = P_Order_ID;

END IF;

COMMIT;

EXCEPTION
when others then

lv_errcode := SQLCODE;
lv_errmsg := substr(SQLERRM,1,30);

sp_Error_log(lv_errcode,lv_errmsg,'SP_NEW_ODR');

END;
/


CREATE or REPLACE PROCEDURE SP_DEL_ODR ( P_odr_ID IN NUMBER)
AS
lv_errcode varchar(100);
lv_errmsg varchar(30);

BEGIN
    DELETE FROM Orders
			WHERE Order_ID = P_Odr_ID;

COMMIT;

EXCEPTION
when others then
lv_errcode := SQLCODE;
lv_errmsg := substr(SQLERRM,1,30);

sp_Error_log(lv_errcode,lv_errmsg,'SP_DEL_ODR');

END;
/

