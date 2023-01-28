/*-----------------------------------------------------------------------------------------------------
	FILE: CREATE_TABLE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN UNNAMED BLOCK WHICH HAVE DUMMY DATSET 
	AUTHOR: SELVA
	DATE CREATED: 04/09/2019
*/-----------------------------------------------------------------------------------------------------

--DUMMY DATASET

BEGIN
SP_NEW_PRD(1, 1, 'Product 1', 'Description 1', 10.5, 100);
SP_NEW_PRD(1, 2, 'Product 2', 'Description 2', 15.0, 50);
SP_NEW_PRD(1, 3, 'Product 3', 'Description 3', 20.0, 25);
SP_NEW_PRD(1, 4, 'Product 4', 'Description 4', 25.5, 10);
SP_NEW_PRD(1, 5, 'Product 5', 'Description 5', 30.0, 5);
END;
/

BEGIN
SP_NEW_CUS (1, 12, 'Sam', 'John', 'samjohn@gmail.com', '555-555-5558', '321 Oak St');
SP_NEW_CUS (1, 14, 'Joe', 'Don', 'joedon@gmail.com', '555-555-5555', '123 Main St');
SP_NEW_CUS (1, 15, 'Jan', 'Smile', 'jansmile@gmail.com', '555-555-5556', '456 Park Ave');
SP_NEW_CUS (1, 122, 'Bob', 'Joe', 'bobjoe@gmail.com', '555-555-5557', '789 Elm St');
END;
/

--CHECK TABLE IS UPDATED OR NOT
BEGIN
SP_NEW_CUS (2, 2, 'Sam', 'Joe', 'samjoe@gmail.com', '554-444-5558', '321 Oak St');
END;
/


BEGIN
SP_NEW_ODR(1, 6, 1, '21-01-23', 1, 20.99);
SP_NEW_ODR(1, 7, 1, '21-01-22', 1, 30.99);
SP_NEW_ODR(1, 4, 3, '21-01-21', 3, 40.99);
SP_NEW_ODR(1, 7, 2, '21-01-22', 4, 50.99);
SP_NEW_ODR(1, 99, 5, '21-01-22', 3, 60.99);
END;
/

--CHECK RECORD IS DELETED OR NOT
/*
BEGIN
SP_DEL_ODR(5);
END;
/

*/

--Function to calculate total sales by product.
SELECT SF_totsal_prd (1, 30) AS DOLLAR FROM DUAL;