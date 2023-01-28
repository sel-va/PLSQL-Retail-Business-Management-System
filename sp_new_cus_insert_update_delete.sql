/*-----------------------------------------------------------------------------------------------------
	FILE: SP_NEW_CUS_INSERT_UPDATE_DELETE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN STORED PROCEDURE FOR CUSTOMER
	AUTHOR: SELVA
	DATE CREATED: 05/09/2019
*/-----------------------------------------------------------------------------------------------------


/*
The database will have the ability to add new customers to the customers table.
The database will have the ability to update existing customer information in the customers table.
The database will have the ability to delete customers from the customers table.
*/

CREATE or REPLACE PROCEDURE SP_NEW_CUS (
	P_userip IN INTEGER,
	P_Customer_ID IN INTEGER,
	P_First_Name IN VARCHAR,
	P_Last_Name IN VARCHAR,
	P_Email IN	VARCHAR,
	P_Phone IN	VARCHAR,
	P_Address IN	VARCHAR)
AS
lv_errcode varchar(20);
lv_errmsg varchar(30);
BEGIN
--1 MEANS INSERT
IF P_userip = 1 THEN 
	INSERT INTO Customers 
	VALUES (
		seq_cus_id.nextval,
		P_First_Name,
		P_Last_Name,
		P_Email,
		P_Phone,
		P_Address
		);
ELSIF P_userip = 2 THEN
	UPDATE Customers 
	SET First_name = p_First_name, 
		Last_name = p_Last_name, 
		Email = p_Email, 
		Phone = p_Phone, 
		Address = p_Address
			WHERE Customer_ID = P_Customer_ID;
END IF;
COMMIT;

EXCEPTION
	when others then
	lv_errcode := SQLCODE;
	lv_errmsg := substr(SQLERRM,1,30);
	sp_Error_log(lv_errcode,lv_errmsg,'SP_NEW_CUS');

END;
/




CREATE or REPLACE PROCEDURE SP_DEL_CUS ( P_Customer_ID IN INTEGER)
AS
lv_errcode varchar(100);
lv_errmsg varchar(30);

BEGIN
    DELETE FROM Customers
			WHERE Customer_ID = P_Customer_ID;

COMMIT;

EXCEPTION
when others then
lv_errcode := SQLCODE;
lv_errmsg := substr(SQLERRM,1,30);

sp_Error_log(lv_errcode,lv_errmsg,'SP_NEW_CUS');

END;
/


