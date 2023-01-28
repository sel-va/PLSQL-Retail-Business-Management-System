# PLSQL-Retail-Business-Management-System

PROJECT INTRODUCTION
====================
  The GitHub project for level 1 freshers in PL/SQL technology is designed to provide a hands-on experience with the technology, while also helping them to understand how a real-world database is structured and maintained. The project focuses on creating a database that can store and manage data for a small retail business. This includes creating tables for storing information about products, customers, and orders, as well as procedures and functions for performing common tasks such as adding new products, processing orders, and generating reports. The project also includes sample data and queries to help freshers understand how the database works and how to interact with it using PL/SQL. By working on this project, freshers will gain a solid understanding of the basics of PL/SQL and how it can be used in a practical setting.
--------------------------------------------------------------------------------------------------------
Business Requirement Document for a small project having three tables
======================================================================
Introduction
==============
This document outlines the business requirements for a small database development project. 
The project aims to create a database that can store and manage data for a small retail business. 
The database will include three main tables: customers, orders, and products.

Business Requirements
=======================
The customers table will store information about the business's customers, including their name, address, and contact information.
The orders table will store information about the orders placed by customers, including the customer's name, the order date, and the products included in the order.
The products table will store information about the products sold by the business, including product name, price, and quantity in stock.

Functional Requirements
=========================
The database will have the ability to add new customers to the customers table.
The database will have the ability to update existing customer information in the customers table.
The database will have the ability to delete customers from the customers table.
The database will have the ability to add new orders to the orders table.
The database will have the ability to update existing orders in the orders table.
The database will have the ability to delete orders from the orders table.
The database will have the ability to add new products to the products table.
The database will have the ability to update existing products in the products table.
The database will have the ability to delete products from the products table.
The database will have the ability to generate reports on customer and order data.

Technical Requirements
=======================
The database will be built using PLSQL.
The database will be hosted on a Linux server.
The database will be accessible through a web-based interface using PHP.
The database will be backed up regularly to ensure data integrity and availability.

Conclusion
=============
This Business Requirement Document outlines the requirements for a small database development project that will store and manage data for a retail business. 
The project will include three main tables: customers, orders, and products. 
The database will have the ability to add, update, and delete data in each of these tables and will have the ability to generate reports 
on customer and order data. The database will be built using oracle SQL, hosted on a Linux server, and will be accessible through a web-based interface using PHP.

--------------------------------------------------------------------------------------------------------------

Physical Data Model 
===================
Physical Data Model for a database development project with tables for customers, orders, and products:
<PRE>
Table Name: Customers
-----------------------
Column Name: Customer_ID (Primary key)
Column Data type: INTEGER
Column Name: First_Name
Column Data type: VARCHAR(50)
Column Name: Last_Name
Column Data type: VARCHAR(50)
Column Name: Email
Column Data type: VARCHAR(255)
Column Name: Phone
Column Data type: VARCHAR(20)
Column Name: Address
Column Data type: VARCHAR(255)
Primary key: Customer_ID
Foreign key: None
Indexes: None
Constrains: Email should be unique
Partitions: None


Table Name: Orders
----------------------
Column Name: Order_ID (Primary key)
Column Data type: INTEGER
Column Name: Customer_ID (Foreign key)
Column Data type: INTEGER
Column Name: Order_Date
Column Data type: DATE
Column Name: Total_Amount
Column Data type: DECIMAL(10,2)
Primary key: Order_ID
Foreign key: Customer_ID references Customers(Customer_ID)
Indexes: None
Constrains: None
Partitions: Partitioned by Order_Date


Table Name: Products
----------------------
Column Name: Product_ID (Primary key)
Column Data type: INTEGER
Column Name: Product_Name
Column Data type: VARCHAR(255)
Column Name: Product_Description
Column Data type: VARCHAR(255)
Column Name: Product_Price
Column Data type: DECIMAL(10,2)
Column Name: Product_Stock
Column Data type: INTEGER
Primary key: Product_ID
Foreign key: None
Indexes: None
Constrains: Product_Stock should be greater than or equal to zero
Partitions: None
</PRE>
