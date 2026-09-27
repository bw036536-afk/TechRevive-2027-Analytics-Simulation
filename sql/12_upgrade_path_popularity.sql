-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: What sells the most.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Question: Which upgrade path appears in more orders: a la carte or bundles?
-- Display-label clarification: number_of_rows was renamed number_of_orders.
-- The original COUNT(DISTINCT order_id) calculation is unchanged.
SELECT
    analysis_product_type AS upgrade_path,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM techrevive_2027.sales_2027_flat
-- Step 1: Compare standalone individual upgrades with upgrade bundles.
-- Repair-service add-ons are outside this comparison.
WHERE analysis_product_type IN(
    'Individual upgrades', 'Upgrade bundle'
)
-- Step 2: Count each order once within each path; an order can use both paths.
GROUP BY analysis_product_type
-- Step 3: Rank the paths by distinct order count.
ORDER BY number_of_orders DESC;
