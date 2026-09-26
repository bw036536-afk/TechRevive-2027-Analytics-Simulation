-- TechRevive 2027 | Sales analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: Is revenue growing or declining over 2027.sql
-- Original query logic preserved; comments and whitespace organized for readability.
-- Requires techrevive_2027.orders_2027. See the root README for run assumptions.

-- Question: Which order IDs, dates, and subtotals are available for the revenue growth analysis? (Preliminary data check.)
SELECT
    order_id,
    order_date,
    subtotal_usd
FROM techrevive_2027.orders_2027;

-- Question: How does monthly revenue change from the previous month during the simulated 2027 year?
SELECT
    TO_CHAR(order_date, 'mm, FMMon'),
    SUM(subtotal_usd) AS monthlyTotal,
    LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon')) prevMonthSales,
    CAST(((SUM(subtotal_usd) - LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon')))
    / LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon'))) * 100 AS INT) AS monthlyGrowthPercent
FROM techrevive_2027.orders_2027
WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
GROUP BY TO_CHAR(order_date, 'mm, FMMon')
ORDER BY TO_CHAR(order_date, 'mm, FMMon');

-- Question: How does monthly revenue change after excluding orders categorized as Premium or Masterpiece?
SELECT
    TO_CHAR(order_date, 'mm, FMMon'),
    SUM(subtotal_usd) AS monthlyTotal,
    LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon')) prevMonthSales,
    CAST(((SUM(subtotal_usd) - LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon')))
    / LAG(SUM(subtotal_usd)) OVER(ORDER BY TO_CHAR(order_date, 'mm, FMMon'))) * 100 AS INT) AS monthlyGrowthPercent
FROM techrevive_2027.orders_2027
WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
    AND (primary_category != 'Premium' AND primary_category != 'Masterpiece')
GROUP BY TO_CHAR(order_date, 'mm, FMMon')
ORDER BY TO_CHAR(order_date, 'mm, FMMon');
