use project;
show tables;
Select * from cleaned_walmart_sales_analysis;
SELECT Month, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Month
ORDER BY Total_Sales DESC Limit 5;
SELECT Year, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Year
ORDER BY Total_Sales DESC;
SELECT Store_Number, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Store_Number
ORDER BY Total_Sales DESC Limit 5;
SELECT Temperature, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Temperature
ORDER BY Total_Sales DESC Limit 5;
SELECT Fuel_Price, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Fuel_Price
ORDER BY Total_Sales DESC Limit 5;
SELECT CPI, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY CPI
ORDER BY Total_Sales DESC Limit 5;
SELECT Unemployment, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Unemployment
ORDER BY Total_Sales DESC Limit 5;
SELECT Holiday_Flag, SUM(Weekly_Sales) AS Total_Sales
FROM cleaned_walmart_sales_analysis
GROUP BY Holiday_Flag
ORDER BY Total_Sales DESC;
SELECT COUNT(DISTINCT Store_Number) AS Distinct_Stores
FROM cleaned_walmart_sales_analysis;
SELECT
    Store_Number,
    SUM(Weekly_Sales) AS Total_Sales,
    CASE
        WHEN SUM(Weekly_Sales) >= 100000000 THEN 'High Value'
        WHEN SUM(Weekly_Sales) >= 50000000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Store_Value
FROM cleaned_walmart_sales_analysis
GROUP BY Store_Number
ORDER BY Total_Sales DESC;
SELECT
    Store_Number,
    SUM(Weekly_Sales) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Weekly_Sales) DESC
    ) AS `Rank`
FROM cleaned_walmart_sales_analysis
GROUP BY Store_Number;
SELECT
    Month,
    SUM(Weekly_Sales) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Weekly_Sales) DESC
    ) AS `Rank`
FROM cleaned_walmart_sales_analysis
GROUP BY Month;
WITH Store_Sales AS (
    SELECT
        Store_Number,
        SUM(Weekly_Sales) AS Total_Sales
    FROM cleaned_walmart_sales_analysis
    GROUP BY Store_Number
)
SELECT
    Store_Number,
    Total_Sales,
    SUM(Total_Sales) OVER (
        ORDER BY Total_Sales DESC
    ) AS Running_Total
FROM Store_Sales;
SELECT
    Store_Number,
    SUM(Weekly_Sales) AS Total_Sales,
    ROUND(
        SUM(Weekly_Sales) * 100.0 /
        SUM(SUM(Weekly_Sales)) OVER (),
        2
    ) AS Sales_Contribution_Percentage
FROM cleaned_walmart_sales_analysis
GROUP BY Store_Number
ORDER BY Sales_Contribution_Percentage DESC;