/*-----------------------------------------------------------------------------------------------------
	FILE: CREATE_TABLE.SQL
	DESCRIPTION: THIS SCRIPT CONTAIN TABLE CREATION FOR CUSTOMERS, ORDERS, PRODUCTS
	AUTHOR: SELVA
	DATE CREATED: 04/09/2019
*/-----------------------------------------------------------------------------------------------------

-- CREATE TABLE FOR CUSTOMER 
--The customers table will store information about the business's customers, including their name, address, and contact information.

CREATE TABLE Customers(
	Customer_ID INTEGER Primary key,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(50) NOT NULL,
	Email	VARCHAR(255) UNIQUE,
	Phone	VARCHAR(20),
	Address	VARCHAR(255)
);



-- CREATE TABLE FOR PRODUCTS 
--The orders table will store information about the orders placed by customers, including the customer's name, the order date, and the products included in the order.

CREATE TABLE Products
	(
	Product_ID INTEGER Primary key,
	Product_Name VARCHAR(255),
	Product_Description VARCHAR(255),
	Product_Price DECIMAL(10,2),
	Product_Stock INTEGER  CHECK(Product_Stock >=0)
);



--FIRST CREATE ABOVE 2 PARENT TABLE THEN CREATE BELOW CHILD TABLE, BECAUSE OF FOREIGN KEY

-- CREATE TABLE FOR ORDERS 
--The products table will store information about the products sold by the business, including product name, price, and quantity in stock.


CREATE TABLE Orders 
(       Order_ID NUMBER(10) PRIMARY KEY,
		Customer_ID INTEGER NOT NULL,
		Order_Date DATE NOT NULL,
		Product_ID INTEGER NOT NULL,
		Total_Amount DECIMAL(10,2) NOT NULL,
		CONSTRAINT FK_Orders_Customers FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
		CONSTRAINT FK_Orders_product FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID));


--PARTITION BY RANGE (Order_Date)
--(
--		PARTITION P_Orders_Current VALUES LESS THAN (TO_DATE('2022-01-01', 'yyyy-mm-dd')),
--		PARTITION P_Orders_Previous VALUES LESS THAN (MAXVALUE));



-- CREATE TABLE FOR ERROR LOG

CREATE TABLE error_log
(
ERRCODE	VARCHAR2(10),
ERRMSG  VARCHAR(30),
USERNAME  VARCHAR2(10),
ERRTIME TIMESTAMP,
BLOCKNAME VARCHAR2(30)
);

--select * from user_tables;




