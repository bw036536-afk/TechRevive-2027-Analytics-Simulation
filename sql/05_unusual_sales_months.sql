-- TechRevive 2027 | Sales analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: Which months had unusually high or low sales.sql
-- Original query logic preserved; comments and whitespace organized for readability.
-- Requires techrevive_2027.orders_2027. See the root README for run assumptions.

-- Question: Which months have revenue more than one population standard deviation above or below the monthly mean?
WITH CTE_monthlySales AS (
    SELECT
        TO_CHAR(order_date, 'mm, FMMon') AS salesMonth,
        SUM(subtotal_usd) AS monthlyRevenue
    FROM techrevive_2027.orders_2027
    WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
    GROUP BY TO_CHAR(order_date, 'mm, FMMon')
),

CTE_monthlyComparison AS (
    SELECT
        salesMonth,
        monthlyRevenue,
        AVG(monthlyRevenue) OVER() AS avgRevenue,
        STDDEV_POP(monthlyRevenue) OVER() AS revenueStdDev
    FROM CTE_monthlySales
)

SELECT
    salesMonth,
    monthlyRevenue,
    ROUND(avgRevenue, 2) AS avgMonthlyRevenue,
    CASE
        WHEN monthlyRevenue > avgRevenue + revenueStdDev
            THEN 'Unusually High'
        WHEN monthlyRevenue < avgRevenue - revenueStdDev
            THEN 'Unusually Low'
        ELSE 'Within Parameters'
    END AS salesFlag
FROM CTE_monthlyComparison
ORDER BY salesMonth;

-- Question: Which months meet the same high or low revenue threshold after excluding orders categorized as Premium or Masterpiece?
WITH CTE_monthlySales AS (
    SELECT
        TO_CHAR(order_date, 'mm, FMMon') AS salesMonth,
        SUM(subtotal_usd) AS monthlyRevenue
    FROM techrevive_2027.orders_2027
    WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
        AND primary_category != 'Premium' AND primary_category != 'Masterpiece'
    GROUP BY TO_CHAR(order_date, 'mm, FMMon')
),

CTE_monthlyComparison AS (
    SELECT
        salesMonth,
        monthlyRevenue,
        AVG(monthlyRevenue) OVER() AS avgRevenue,
        STDDEV_POP(monthlyRevenue) OVER() AS revenueStdDev
    FROM CTE_monthlySales
)

SELECT
    salesMonth,
    monthlyRevenue,
    ROUND(avgRevenue, 2) AS avgMonthlyRevenue,
    CASE
        WHEN monthlyRevenue > avgRevenue + revenueStdDev
            THEN 'Unusually High'
        WHEN monthlyRevenue < avgRevenue - revenueStdDev
            THEN 'Unusually Low'
        ELSE 'Within Parameters'
    END AS salesFlag
FROM CTE_monthlyComparison
ORDER BY salesMonth;
