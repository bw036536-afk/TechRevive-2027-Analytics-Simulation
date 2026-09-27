-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: What sells the most.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Question: Which repair tier appears in the most orders?
SELECT
    repair_tier,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM techrevive_2027.sales_2027_flat
-- Step 1: Keep repair-service lines only; ignore bundles and other products.
WHERE analysis_product_type = 'Repair service'
-- Step 2: Group by repair tier and count each order once within that tier.
GROUP BY repair_tier
-- Step 3: Show the tier with the most distinct orders first.
ORDER BY number_of_orders DESC;
