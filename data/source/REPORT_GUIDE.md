# Shopify-style reports to practice

Each report is a derived view of the same fictional 2027 dataset. Reports are supplied as calculation references; you can hide the reports folder while practicing and compare afterward.

| Report CSV | Source | Group by | Main question |
| --- | --- | --- | --- |
| reports/sales_over_time.csv | orders_2027.csv | Month | How do orders, product sales and average order value change across the year? |
| reports/sales_by_channel.csv | orders_2027.csv | Month and sales_channel | How do Online Store and eBay contribute to sales? |
| reports/sales_by_variant_sku.csv | sales_2027_flat.csv | Month, channel and catalog_entry_id | Which real SKU/configuration contributes the most units or sales? |
| reports/conversion_over_time.csv | website_sessions_2027.csv | Month | What percentage of website sessions resulted in a purchase? |
| reports/sessions_by_device.csv | website_sessions_2027.csv | Month and device_type | How do traffic and conversion differ across Mobile, Desktop and Tablet? |
| reports/sessions_by_referrer.csv | website_sessions_2027.csv | Month, referrer_source and referrer_name | How do visits and purchases compare across simulated traffic sources? |

The daily website_traffic_daily_2027.csv is a ready-to-use daily version of the traffic and conversion report. It includes every day of 2027, even when there are no completed checkouts.

## Calculations

| Measure | Calculation |
| --- | --- |
| Orders | Count distinct order_id values |
| Gross sales | Sum quantity x unit_price_usd from item rows, or sum order subtotals once per order |
| Net sales | Gross sales - discounts - sales reversals |
| Average order value | (Gross sales - discounts) / orders |
| Sessions | Count session_id values in website_sessions_2027.csv |
| Pageviews | Sum pageviews in website_sessions_2027.csv |
| Unique online-store visitors | Count distinct visitor_id values over the selected records |
| Converted sessions | Count sessions where completed_checkout is true |
| Online Store conversion percentage | Converted sessions / sessions x 100 |
| Add-to-cart percentage | Sessions with added_to_cart true / sessions x 100 |
| Reached-checkout percentage | Sessions with reached_checkout true / sessions x 100 |
| Checkout-completion percentage | Converted sessions / sessions that reached checkout x 100 |

Discounts and sales reversals are zero in this starter scenario. Gross and net sales therefore match. These are product/service sales measures; taxes, shipping, costs and platform fees are outside scope.

Do not use eBay purchases in website conversion. Do not use pageviews instead of sessions. Do not sum item-level copies of order totals or average daily percentages. For a combined conversion rate, sum the relevant numerator and denominator separately and divide once.

## Keys and relationships

- orders_2027.order_id connects to order_items_2027.order_id: one order can have multiple items.
- products.catalog_entry_id connects to order_items_2027.catalog_entry_id: one catalog entry can appear in many purchases.
- releases_2027.release_id connects to order_items_2027.release_id for limited releases.
- orders_2027.session_id connects to website_sessions_2027.session_id for website purchases. eBay orders have no website session.
- sales_2027_flat.csv already combines order, item and selected product/session details. It has no pageviews column because copying session traffic onto multiple item rows makes it easy to double-count.

## SKU report details

The report retains both the real SKU and catalog_entry_id. A blank SKU does not cause the Mail-In Kit and hypothetical releases to merge into a single product. Catalog and variant IDs keep them distinct. Refurbished source listings with the same title remain separate because their SKUs and variant IDs differ.

An order containing a service and kit counts under both catalog entries in the SKU report. Summing that report's orders column over products will exceed 500. Use orders_2027.csv for the overall order count. Quantities and sales amounts are additive across product rows.

## Useful first exercise

Build a table with one row per month and these columns: website sessions, website pageviews, website orders, converted website sessions, website conversion percentage, eBay orders and all-channel net sales. Aggregate each source to month before joining. Then explain how an increase in total orders could occur without an increase in website conversion.

Use real-business language when presenting the project: "Synthetic TechRevive 2027 scenario using verified catalog prices and SKUs, with assumed sales and traffic." The built-in patterns are not evidence of actual channel performance.
