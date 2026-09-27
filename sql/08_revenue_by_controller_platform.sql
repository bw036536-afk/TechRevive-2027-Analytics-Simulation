-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: Which controller platform generates the most revenue.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Preliminary check: inspect the item-level source before grouping.
-- Run this statement separately when exploring the data.
SELECT
    *
FROM techrevive_2027.sales_2027_flat;

-- Supporting question: Which controller models generate the most revenue?
SELECT
    controller_model,
    SUM(line_total_usd) AS totalControllerRevenue
FROM techrevive_2027.sales_2027_flat
-- Exclude rows not assigned to a controller model, such as mail-in kits.
WHERE controller_model != 'Not applicable'
-- Sum item revenue separately for each controller model.
GROUP BY controller_model
ORDER BY totalControllerRevenue DESC;

-- Main question: Which controller platform generates the most revenue?
WITH CTE_platformSales AS (
    SELECT
        -- Map model-name prefixes to the three broader controller platforms.
        CASE
            WHEN controller_model LIKE 'PS%'
                THEN 'PLAYSTATION'
            WHEN controller_model LIKE 'Xbox%'
                THEN 'XBOX'
            WHEN controller_model LIKE 'Nintendo%'
                THEN 'NINTENDO'
            -- Retain other model names under N/A if they appear in the source.
            ELSE 'N/A'
        END AS platform,
        line_total_usd
    FROM techrevive_2027.sales_2027_flat
-- Remove non-controller rows before calculating platform revenue.
    WHERE controller_model != 'Not applicable'
)

-- Combine model-level item revenue within each platform and rank highest first.

SELECT
    platform,
    SUM(line_total_usd) AS totalRevenue
FROM CTE_platformSales
GROUP BY platform
ORDER BY totalRevenue DESC;
