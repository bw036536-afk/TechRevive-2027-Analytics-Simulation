-- TechRevive 2027 | Sales analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: How much revenue did TechRevive generate by month.sql
-- Original query logic preserved; comments and whitespace organized for readability.
-- Requires techrevive_2027.orders_2027. See the root README for run assumptions.

-- Question: How much revenue did TechRevive generate each month in the simulated 2027 data?
SELECT
    TO_CHAR(order_date, 'mm, FMMon'),
    SUM(subtotal_usd) AS monthlyTotal
FROM techrevive_2027.orders_2027
WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
GROUP BY TO_CHAR(order_date, 'mm, FMMon')
ORDER BY TO_CHAR(order_date, 'mm, FMMon');
