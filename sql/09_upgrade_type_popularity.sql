-- TechRevive 2027 | Product and service analysis | PostgreSQL
-- Fictional practice data; not actual business performance or a forecast.
-- Source: What sells the most.sql
-- Original calculations and filters preserved; comments and formatting added.
-- Requires techrevive_2027.sales_2027_flat (one row per order item).
-- Uses the entire supplied 2027 table; no additional date filter is applied.
-- See the root README for run assumptions and interpretation notes.

-- Preliminary check: inspect the item-level source before filtering upgrades.
SELECT
    *
FROM techrevive_2027.sales_2027_flat;

-- Question: Which individually selected upgrade type appears in the most orders?
WITH eligible_sales AS (
    SELECT
        order_id,
        quantity,
        joystick_upgrade,
        mouse_click_upgrade,
        rear_input_upgrade
    FROM techrevive_2027.sales_2027_flat
-- Step 1: Include repair-service add-ons and individual (a la carte) upgrades.
-- Bundles and finished controllers are excluded from this comparison.
    WHERE analysis_product_type IN (
        'Repair service',
        'Individual upgrades'
    )
),
-- Step 2: Turn the three option columns into one list of selected upgrades.
-- UNION ALL retains selections from every option column; one order can select several types.
upgrade_selections AS (
    SELECT
        order_id,
        quantity,
        joystick_upgrade AS upgrade
    FROM eligible_sales
    -- Count Hall Effect and TMR as separate joystick selections.
    WHERE joystick_upgrade IN ('Hall Effect', 'TMR')

    UNION ALL

    SELECT
        order_id,
        quantity,
        mouse_click_upgrade AS upgrade
    FROM eligible_sales
    -- Keep each mouse-click package name; omit unselected or inapplicable options.
    -- SQL also excludes NULL values from this NOT IN condition.
    WHERE mouse_click_upgrade NOT IN ('None', 'Not applicable')

    UNION ALL

    SELECT
        order_id,
        quantity,
        'Rear inputs / back paddles' AS upgrade
    FROM eligible_sales
    -- Combine the two rear-control labels into one comparable upgrade group.
    WHERE rear_input_upgrade IN (
        'Four Rear Inputs',
        'Four Back Paddles'
    )
)
-- Step 3: Count each order once within each upgrade group and rank by popularity.
-- Counts across upgrade types overlap and must not be added into a total order count.
-- quantity is retained in the source CTEs, but this metric counts orders rather than units.

SELECT
    upgrade,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM upgrade_selections
GROUP BY
    upgrade
ORDER BY
    number_of_orders DESC,
    upgrade;
