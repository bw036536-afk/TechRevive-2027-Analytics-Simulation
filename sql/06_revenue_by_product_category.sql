-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: Which products generate the most revenue.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Question: Which product categories generate the most revenue?
SELECT
    analysis_category,
    -- Add item revenue, rather than repeated order totals, within each category.
    SUM(line_total_usd) AS productRevenue
FROM techrevive_2027.sales_2027_flat
-- Keep Premium, Refurbished, and Masterpiece as separate category groups.
-- Other categories present in the source remain included.
GROUP BY analysis_category
-- Show the highest-revenue category first.
ORDER BY productRevenue DESC;
