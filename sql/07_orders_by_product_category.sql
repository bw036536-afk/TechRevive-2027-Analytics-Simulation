-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: Which products have the highest number of orders.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Question: Which product categories have the highest number of orders?
SELECT
    analysis_category,
    -- Count an order once per category, even if it contains multiple item rows.
    COUNT(DISTINCT order_id) AS numOrders
FROM techrevive_2027.sales_2027_flat
-- Return one result for each category. An order can belong to multiple categories.
GROUP BY analysis_category
-- Rank by distinct orders, not by units sold or number of item rows.
ORDER BY numOrders DESC;
