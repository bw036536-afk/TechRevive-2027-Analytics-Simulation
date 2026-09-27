-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: What sells the most.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Question: Which bundle tier appears in the most orders?
SELECT
    variant_title,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM techrevive_2027.sales_2027_flat
-- Step 1: Select the three named bundle tiers using the original variant-title filter.
-- Assumes these exact variant titles identify bundles in the supplied dataset.
WHERE variant_title IN (
    'OUTBREAK', 'APEX PREDATOR', 'PATIENT ZERO'
)
-- Step 2: Count distinct orders separately for each bundle tier.
GROUP BY variant_title
-- Step 3: Rank the bundle tiers by order count, highest first.
ORDER BY number_of_orders DESC;
