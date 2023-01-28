/*-----------------------------------------------------------------------------------------------------
	FILE: FXN_SP_ERR_LOG.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN FUNCTION TO CALCULATE TOTAL SALES BY PRODUCT AND ERROR LOG PROCEDURE 
	AUTHOR: SELVA
	DATE CREATED: 06/09/2019
*/-----------------------------------------------------------------------------------------------------

--Function to calculate total sales by product.


CREATE or REPLACE FUNCTION SF_totsal_prd (f_prd_id IN NUMBER, f_days IN NUMBER)
    RETURN NUMBER
AS
    LV_TOT NUMBER;
	
BEGIN
    SELECT SUM(Total_Amount) 
    INTO LV_TOT
    FROM orders 
    WHERE Product_ID = f_prd_id AND Order_Date BETWEEN SYSDATE-f_days AND SYSDATE;
    
    RETURN LV_TOT;
    
END;
/
-----------------------------------------------------------------------------------------------

/* ERROR LOG PROCEDURE */

		CREATE OR REPLACE PROCEDURE sp_Error_log(
		p_errcode in varchar,
		p_errmsg in varchar,
		p_blockname in varchar)

		AS
		PRAGMA AUTONOMOUS_TRANSACTION;

		BEGIN
		INSERT INTO error_log values (p_errcode,p_errmsg,user,sysdate,p_blockname);

		COMMIT;
		END;
		/


--SELECT * FROM USER_OBJECTS;
--SELECT TEXT FROM USER_SOURCE WHERE NAME = 'SP_DEL_PRD';
