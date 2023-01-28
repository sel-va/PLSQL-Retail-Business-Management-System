/*-----------------------------------------------------------------------------------------------------
	FILE: SP_SYS_REFCURSOR_OP.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN PROCEDURE WHICH REQUIRED SOME INPUT AND GIVE OUTPUT AS SYSREFCURSOR 
	AUTHOR: SELVA
	DATE CREATED: 06/09/2019
*/-----------------------------------------------------------------------------------------------------

/*
REQUIREMENT:
	GIVE RESULTS FROM SP USING SYS_REFCURSOR 
	MAKE VIEWS THAT BASED ON THE RESULT OF A SELECT STATEMENT 
*/

--LIST OF CURSTOMER ORDERED PARTICULAR PRODUCT

CREATE OR REPLACE PROCEDURE S_NOT_SALE_PRD (PRD_ID IN NUMBER, CUS_DTLS_REFC OUT SYS_REFCURSOR)
AS
BEGIN
	OPEN CUS_DTLS_REFC FOR
	SELECT O.Customer_ID, C.First_Name, C.LAST_NAME FROM ORDERS O INNER JOIN CUSTOMERS C ON O.Customer_ID = C.Customer_ID 
	WHERE PRODUCT_ID = PRD_ID;
END;
/

/*
UNIT_TEST
	VARIABLE X REFCURSOR
	EXEC S_NOT_SALE_PRD(1,:X);
	PRINT X
*/
-----------------------------------------------------------------------------------------------------------------------------
--NUMBER OF ORDER FOR PARTICULAR PRODUCT IN N DAYS

CREATE OR REPLACE PROCEDURE S_NOT_SALE_PRD (PRD_ID IN NUMBER, DAYS_TO_CNT IN NUMBER, NUM_ORD_REFC OUT SYS_REFCURSOR)
AS
BEGIN
	OPEN NUM_ORD_REFC FOR
	SELECT COUNT(ORDER_ID) TOTAL_PRODUCT_SALE FROM ORDERS O WHERE PRODUCT_ID = PRD_ID AND ORDER_DATE >= SYSDATE - DAYS_TO_CNT;
END;
/

/*
UNIT_TEST
	VARIABLE X REFCURSOR
	EXEC S_NOT_SALE_PRD(1,30,:X);
	PRINT X
*/

-----------------------------------------------------------------------------------------------------------------------
--LIST OF PRODUCT, WHICH NOT SALE IN LAST_MONTH

CREATE OR REPLACE PROCEDURE S_NOT_SALE_PRD (DAYS_TO_CNT IN NUMBER, NOT_SALE_REFC OUT SYS_REFCURSOR)
AS
BEGIN
OPEN NOT_SALE_REFC FOR
SELECT P.Product_ID, P.Product_Name, P.Product_Stock
FROM products P where P.PRODUCT_ID not in (select distinct product_id from orders o where O.Order_Date >= SYSDATE - DAYS_TO_CNT);
END;
/

/*
UNIT TEST
	VARIABLE X REFCURSOR
	EXEC S_NOT_SALE_PRD(30,:X);
	PRINT X
*/

------------------------------------------------------------------------------------------------------------------
--PRODUCT HAVE LESS NUMBER OF STOCK

CREATE OR REPLACE PROCEDURE SP_GEN_REP_PRD_LESS_STK (STK_QTY IN INTEGER, LES_STK_REFC OUT SYS_REFCURSOR)
AS
BEGIN
	OPEN LES_STK_REFC FOR 
	SELECT Product_ID, Product_Name, Product_Stock FROM products where Product_Stock <= STK_QTY; 
END;
/

--UNIT TEST
-- VARIABLE X REFCURSOR
--EXEC SP_GEN_REP_TOTREV_NO_DAYS(STK_QTY=>30, LES_STK_REFC=>:X);
--PRINT X

-------------------------------------------------------------------------------------------------------------------------

--TOTAL ORDER PLACED FOR LAST N DAYS AND ITS PRICE

CREATE OR REPLACE VIEW V_TOT_ODR_PLCED_30_DAYS AS
	SELECT COUNT(Order_ID) as Total_Orders, SUM(Total_Amount) as Total_Revenue  FROM ORDERS	WHERE Order_Date >= TRUNC(SYSDATE) - 30;

--SELECT COUNT(Order_ID) as Total_Orders, SUM(Total_Amount) as Total_Revenue  FROM ORDERS	WHERE Order_Date >= TRUNC(SYSDATE) - 15;
--SELECT COUNT(Order_ID) as Total_Orders, SUM(Total_Amount) as Total_Revenue  FROM ORDERS	WHERE Order_Date >= TRUNC(SYSDATE) - 5;


CREATE OR REPLACE PROCEDURE SP_GEN_REP_TOTREV_NO_DAYS (DAYS_TO_CNT IN INTEGER, ODR_REV_REFC OUT SYS_REFCURSOR)
AS
BEGIN
	OPEN ODR_REV_REFC FOR
	SELECT COUNT(Order_ID) as Total_Orders, SUM(Total_Amount) as Total_Revenue 
	FROM ORDERS
	WHERE Order_Date >= TRUNC(SYSDATE) - DAYS_TO_CNT;
END;
/

--UNIT TEST
-- VARIABLE X REFCURSOR
--EXEC SP_GEN_REP_TOTREV_NO_DAYS(DAYS_TO_CNT=>30, ODR_REV_REFC=>:X);
--PRINT X

--------------------------------------------------------------------------------------------------------
--LIST OF PRODUCTS SELLING ABOVE N NUMBERS QTY

CREATE OR REPLACE PROCEDURE SP_GEN_REP_FR_TOP_SELL_PDT (TSP_COUNT IN INTEGER, TSP_REFC OUT SYS_REFCURSOR)
AS

BEGIN
  OPEN TSP_REFC FOR
WITH TT_TOP_SELL_PDT AS (
    SELECT P.PRODUCT_NAME, COUNT(O.PRODUCT_ID) AS COUNT_OF_ORDERS,
    RANK() OVER (ORDER BY COUNT(O.PRODUCT_ID) DESC) AS RANK
    FROM ORDERS O 
    INNER JOIN PRODUCTS P ON O.PRODUCT_ID = P.PRODUCT_ID 
    GROUP BY PRODUCT_NAME 
)
SELECT PRODUCT_NAME, COUNT_OF_ORDERS FROM TT_TOP_SELL_PDT
WHERE RANK <=TSP_COUNT
ORDER BY RANK;

END;
/

--UNIT_TEST
--VARIABLE X REFCURSOR
--EXEC SP_GEN_REP_FR_TOP_SELL_PDT(TSP_COUNT=>1, TSP_REFC=>:X);
--PRINT X

--VARIABLE X REFCURSOR
--EXEC SP_GEN_REP_FR_TOP_SELL_PDT(TSP_COUNT=>2, TSP_REFC=>:X);
--PRINT X
----------------------------------------------------------------------------------------------

--DISPLAY CUSTOMER ORDER HISTORY, USING CUSTOMER_ID
--OUTPUT USING REFCURSOR

CREATE OR REPLACE PROCEDURE SP_GEN_FR_CUS_ODR_AMT_WOBIND (P_CUST_ID IN INTEGER, P_OUTPUT OUT SYS_REFCURSOR)
AS
BEGIN
  OPEN P_OUTPUT FOR
    SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, O.ORDER_DATE, O.TOTAL_AMOUNT
    FROM CUSTOMERS C
    JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
    WHERE C.CUSTOMER_ID = P_CUST_ID;
END;
/

--variable x refcursor
--exec SP_GEN_REP_FR_CUS_ODR_AMT_WOBIND(p_cust_id=>1, p_output=>:x);
--print x

--------------------------------------------------------------------------------------
--NOT WORKING

CREATE OR REPLACE PROCEDURE gen_rep_fr_cus_odr_amt_wbind (p_cust_id IN INTEGER, p_output OUT SYS_REFCURSOR)
AS
  l_query VARCHAR2(1000);
BEGIN
 l_query := 'SELECT c.customer_id, c.first_name, c.last_name, o.order_date, o.total_amount ' ||
             'FROM customers c '||
             'JOIN orders o ON c.customer_id = o.customer_id '||
             'WHERE c.customer_id = :cust_id';

 EXECUTE IMMEDIATE l_query INTO p_output USING p_cust_id;
END;
/

--VARIABLE X REFCURSOR
--EXEC GEN_REP_FR_CUS_ODR_AMT_WBIND(P_CUST_ID=>1, P_OUTPUT=>:X);
--PRINT X

---------------------------------------------------------------------------------------------------------------------------------

--Using CSV export
--Using REST API : API (Application Programming Interface) using REST (Representational State Transfer). 
--Using JDBC