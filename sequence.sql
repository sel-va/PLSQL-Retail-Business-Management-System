/*-----------------------------------------------------------------------------------------------------
	FILE: SEQUENCE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN SEQUENCE FOR CUSTOMER ID, ORDER ID, PRODUCT ID 
	AUTHOR: SELVA
	DATE CREATED: 04/09/2019
*/-----------------------------------------------------------------------------------------------------

create SEQUENCE seq_cus_id 
	START WITH 1 
	INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;


create SEQUENCE seq_odr_id 
	START WITH 1 
	INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;


create SEQUENCE seq_prd_id 
	START WITH 1 
	INCREMENT BY 1 MINVALUE 1 MAXVALUE 99999 NOCYCLE;

