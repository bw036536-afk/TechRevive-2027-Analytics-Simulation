-- TechRevive 2027 | Sales analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: How many orders is TechRevive receiving each month.sql
-- Original query logic preserved; comments and whitespace organized for readability.
-- Requires techrevive_2027.orders_2027. See the root README for run assumptions.

-- Question: Which order IDs, dates, and subtotals are available for the monthly order analysis? (Preliminary data check.)
SELECT
    order_id,
    order_date,
    subtotal_usd
FROM techrevive_2027.orders_2027;

-- Question: How many orders did TechRevive receive each month in the simulated 2027 data?
SELECT
    TO_CHAR(order_date, 'mm, FMMon') AS orderMonth,
    COUNT(order_id) AS numOrders
FROM techrevive_2027.orders_2027
WHERE order_date >= '01/01/2027' AND order_date <= '12/31/2027'
GROUP BY TO_CHAR(order_date, 'mm, FMMon')
ORDER BY TO_CHAR(order_date, 'mm, FMMon');
