-- TechRevive 2027 | Sales analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: What is the average order value.sql
-- Original query logic preserved; comments and whitespace organized for readability.
-- Requires techrevive_2027.orders_2027. See the root README for run assumptions.

-- Question: Which order IDs, dates, and subtotals are available for the average order value analysis? (Preliminary data check.)
SELECT
    order_id,
    order_date,
    subtotal_usd
FROM techrevive_2027.orders_2027;

-- Question: What is the average order value across all orders in the simulated 2027 table?
SELECT
    TO_CHAR(AVG(subtotal_usd), 'FML999D99') AS avgOrderValue_2027
FROM techrevive_2027.orders_2027;

-- Question: What is the average order value after excluding orders categorized as Premium or Masterpiece?
SELECT
    TO_CHAR(AVG(subtotal_usd), 'FML999D99') AS avgOrderValue_2027
FROM techrevive_2027.orders_2027
WHERE primary_category != 'Premium' AND primary_category != 'Masterpiece';
