Create Database KMS_db
Select * [KMS sql Case Study]

----QUESTION ONE----
----Create Poduct Category with the Highest Sales----

SELECT TOP 1
    Product_Category,
    FORMAT(SUM(Sales), 'N2') AS TotalSales
FROM 
    [KMS sql Case Study]
GROUP BY 
    Product_Category
ORDER BY 
    SUM(Sales) DESC;



	-----QUESTION TWO (A)-----
	----TOP THREE REGIONS BY SALES---

SELECT TOP 3
    Region,
    FORMAT(SUM(Sales), 'N2') AS TotalSales
FROM 
    [KMS sql Case Study]
GROUP BY 
    Region
ORDER BY 
    SUM(Sales) DESC;

	

	-----QUESTION TWO (B)-----
----BOTTOM THREE REGIONS BY SALES---

SELECT TOP 3
    Region,
    FORMAT(SUM(Sales), 'N2') AS TotalSales
FROM 
    [KMS sql Case Study]
GROUP BY 
    Region
ORDER BY 
    SUM(Sales) ASC;


-----QUESTION THREE-----
----TOTAL SALES OF APPLIANCES IN ONTARIO------

Select * from [KMS sql Case Study]


SELECT 
    FORMAT(SUM(Sales), 'N2') AS TotalSales_Appliances_Ontario
FROM 
    [KMS sql Case Study]
WHERE 
    Product_Sub_Category = 'Appliances'
    AND Province = 'Ontario';



-----QUESTION FOUR (A)-------
-----RECOMMENDATION ON WHAT TO DO INCREASE THE REVENUEFROM THE 10 BOTTOM CUSTOMERS

SELECT TOP 10 
    Customer_Name,
    FORMAT(SUM(Sales), 'N2') AS Total_Sales,
    COUNT(Order_ID) AS Total_Orders,
    FORMAT(AVG(Sales), 'N2') AS Avg_Order_Value,
    MAX(Order_Date) AS Last_Purchase_Date
FROM [KMS sql Case Study]
GROUP BY Customer_Name
ORDER BY SUM(Sales) ASC;

-----QUESTION FOUR (Bi)-------
-----CUSTOMER RECOMMENDATION TABLE------
CREATE TABLE Customer_Recommendations (
    Customer_Name VARCHAR(255) PRIMARY KEY,
    Total_Sales DECIMAL(18, 2),
    Last_Purchase_Date DATE,
    Recommendation TEXT
);

-----QUESTION FOUR (Bii)-------

INSERT INTO Customer_Recommendations (Customer_Name, Total_Sales, Last_Purchase_Date, Recommendation)
VALUES 
('Jeremy Farry', 85.72, '2012-04-25', 'Re-engage with “We Miss You” email and 10% off next order.'),
('Natalie DeCharney', 125.90, '2010-06-14', 'Send product bundle promo to encourage return.'),
('Nicole Fjeld', 153.03, '2010-09-01', 'Offer bundle discounts and cross-category suggestions.'),
('Katina Edelman', 180.38, '2011-06-06', 'Send free shipping promo and reorder reminder.'),
('Dorothy Dickinson', 198.08, '2010-05-07', 'Loyalty offer and product recommendation.'),
('Christine Kargaltis', 293.22, '2011-09-07', 'Cross-sell premium items, offer volume discount.'),
('Eric Murdock', 343.33, '2012-09-28', 'Loyalty points or seasonal discount incentive.'),
('Chris McAfee', 350.18, '2011-07-06', 'Subscription model suggestion for recurring orders.'),
('Ricki Hutwhaite', 415.82, '2011-07-12', 'Offer volume-based discount and upsell combos.'),
('Dorothy Dickenson', 420.56, '2010-06-10', 'Re-engage with premium gift and welcome-back offer.');
	
SELECT * FROM Customer_Recommendations;


------QUESTION FIVE-----
----WHICH SHIPPING METHOD INCURRED THE MOST SHIPPING COST----------	

SELECT 
    Ship_Mode,
    FORMAT(SUM(Shipping_Cost), 'N2') AS Total_Shipping_Cost
FROM [KMS sql Case Study]
GROUP BY Ship_Mode
ORDER BY SUM(Shipping_Cost) DESC;


-----QUESTION SIX (A)
------THE MOST VALUABLE CUSTOMER------


SELECT 
    Customer_Name,
    FORMAT(SUM(Sales), 'N2') AS Total_Sales,
    COUNT(Order_ID) AS Total_Orders,
    FORMAT(AVG(Sales), 'N2') AS Avg_Order_Value,
    MAX(Order_Date) AS Last_Purchase
FROM [KMS sql Case Study]
GROUP BY Customer_Name
ORDER BY SUM(Sales) DESC;

-----QUESTION SIX (B)
------WHAT PRODUCTS OR SERVICES THEY PURCHASE TYPICALLY------


-------USING TOP 10 CUSTOMERS------

WITH TopCustomers AS (
    SELECT TOP 10 
        Customer_Name,
        SUM(Sales) AS Total_Sales
    FROM [KMS sql Case Study]
    GROUP BY Customer_Name
    ORDER BY Total_Sales DESC
)

SELECT 
    o.Customer_Name,
    o.Product_Category,
    o.Product_Sub_Category,
    COUNT(o.Order_ID) AS Order_Count,



    FORMAT(SUM(o.Sales), 'N2') AS Total_Spent
FROM [KMS sql Case Study] o
JOIN TopCustomers t
    ON o.Customer_Name = t.Customer_Name
GROUP BY o.Customer_Name, o.Product_Category, o.Product_Sub_Category
ORDER BY o.Customer_Name, SUM(o.Sales) DESC;


-----QUESTION SEVEN-----
----THE SMALL BUSINESS CUSTOMER WITH THE HIGHEST SALES-----


SELECT TOP 1 
    Customer_Name,
    FORMAT(SUM(Sales), 'N2') AS Total_Sales
FROM [KMS sql Case Study]
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY SUM(Sales) DESC;


-----QUESTION EIGHT------
-----THE CORPORATE CUSTOMER THAT PLACED THE MOST NUMBER OF ORDERS IN 2009-2012-----

SELECT TOP 1
    Customer_Name,
    COUNT(Order_ID) AS Total_Orders
FROM [KMS sql Case Study]
WHERE Customer_Segment = 'Corporate'
  AND Order_Date BETWEEN '2009-01-01' AND '2012-12-31'
GROUP BY Customer_Name
ORDER BY Total_Orders DESC;


-------QUESTION NINE------
----THE CONSUMER CUSTOMER WITH THE MOST PROFIT----

SELECT TOP 1
    Customer_Name,
    FORMAT(SUM(Profit), 'N2') AS Total_Profit
FROM [KMS sql Case Study]
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY SUM(Profit) DESC;


-----QUESTION TEN------







------QUESTION ELEVEN-----



SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(Order_ID) AS Total_Orders,
    FORMAT(AVG(Shipping_Cost), 'N2') AS Avg_Shipping_Cost
FROM [KMS sql Case Study]
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Ship_Mode;