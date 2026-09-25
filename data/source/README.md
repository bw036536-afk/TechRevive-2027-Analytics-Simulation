# TechRevive 2027 practice dataset, version 2

Use this version for the project. It replaces the first dataset with exact Shopify catalog identifiers on sales rows, sales channels, simulated website traffic, and six Shopify-style report CSVs.

All 500 orders and all traffic are fictional. Real catalog titles, variant titles, SKUs, product IDs, variant IDs, handles, vendor fields and prices were refreshed from the connected TechRevive store on September 25, 2026. This is a practice scenario, not actual business performance or a forecast.

## Start with these files

1. `sales_2027_flat.csv`: 603 item rows covering 500 orders. Includes SKU, real catalog IDs, sales channel, service selections and prices. Count distinct order IDs for order counts.
2. `website_traffic_daily_2027.csv`: one row per day, including days with no purchases. Contains sessions, pageviews, visitor counts, cart additions, checkout sessions and conversion rates.
3. `reports/`: six report examples calculated from the underlying records. Use them to understand Shopify-style reporting or check reports you build yourself.
4. `data_dictionary.csv`: definitions and suggested import types for every column in every data and report file.

`REPORT_GUIDE.md` describes which source records feed each report and how to calculate its measures.

## Files and row meanings

| File | Rows | One row represents |
| --- | ---: | --- |
| orders_2027.csv | 500 | One order |
| order_items_2027.csv | 603 | One product/service item within an order |
| sales_2027_flat.csv | 603 | One item, with its order and catalog details already attached |
| products.csv | 64 | One real priced variant/template or hypothetical release |
| releases_2027.csv | 8 | One Premium or Masterpiece release |
| website_sessions_2027.csv | 18,847 | One simulated visit to the Shopify online store |
| website_traffic_daily_2027.csv | 365 | Website activity on one date |
| reports/sales_over_time.csv | 12 | All-channel sales in one month |
| reports/sales_by_channel.csv | 24 | Sales for one month and sales channel |
| reports/sales_by_variant_sku.csv | 275 | Sales for one month, channel and catalog entry |
| reports/conversion_over_time.csv | 12 | Online Store traffic and conversion in one month |
| reports/sessions_by_device.csv | 36 | Online Store traffic for one month and device type |
| reports/sessions_by_referrer.csv | 60 | Online Store traffic for one month and referrer |
| data_dictionary.csv | 209 | One column definition |

The flat file repeats data from orders, items and products. Reports repeat aggregates of those records. Do not append different versions or report rows to the raw sales as extra transactions.

## Catalog identity and SKUs

- `sku` is copied exactly from the real Shopify variant. It appears in products, order items, flat sales and the SKU report.
- `product_id` and `variant_id` now mean actual Shopify IDs. Import them as text. A Shopify product may have many variants.
- `catalog_entry_id` is the P-prefixed dataset key, such as P002. Use it to join to products. It also gives hypothetical releases a usable join key while their real IDs remain blank.
- Real `product_title`, `variant_title`, `product_handle`, `vendor`, `shopify_product_type` and `product_status` values are preserved. A blank Shopify product-type field stays blank.
- `analysis_category` and `analysis_product_type` are convenient custom analysis groupings. They are separate from the real Shopify fields.
- The actual Mail-In Kit variant used by this scenario belongs to TechRevive Service Add-Ons, variant ID 53147452932377. Its SKU is blank in Shopify, so the dataset preserves that blank and labels it `blank_in_shopify`. The separate Prepaid Mail-in Kit product has SKU TR-MAILKIT, but that different product's SKU has not been copied onto this variant.
- Premium and Masterpiece products have not been created. Their real SKU, product ID and variant ID remain blank, with `sku_status = not_created_hypothetical_release`. Their names, release schedule and prices remain explicitly simulated.
- All five active refurbished source listings are represented separately. Listings with identical titles and prices retain their distinct source variant IDs and SKUs.

Refurbished listings currently identify exact physical units, often already sold out. Repeated simulated sales assume future comparable restocks at the same reference price. The source SKU is deliberately retained as a catalog template; each hypothetical physical controller has a unique `simulated_unit_id`. This is not a reconstruction of actual unit inventory or a claim that one physical controller sold repeatedly.

On eBay sales, the SKU and title refer to the verified Shopify catalog. Actual eBay listing titles, listing IDs, marketplace SKUs and fees were not accessed or invented. This scenario assumes the same catalog price on eBay and the website.

## Approved channel mix

There are still 180 repair, 130 upgrade, 98 refurbished, 90 Premium and two Masterpiece orders. The 130 upgrades include 80 individual-upgrade orders and 50 bundles. Optional Mail-In Kits add 103 item rows within those orders.

The owner approved approximately 80% eBay and 20% Online Store for refurbished sales. Whole-order rounding produces 78 eBay refurbished orders and 20 Online Store refurbished orders: 79.59% and 20.41%. All other orders use Online Store.

Totals are 78 eBay orders and 422 Online Store orders. `sales_channel` means where the customer purchased; `referrer_source` and `referrer_name` mean how a website visitor arrived. Google is a referrer, not an additional sales channel.

The eBay channel is a scenario label, not confirmation that the store currently has a Shopify eBay connector or that eBay sales appear under that exact name in actual Shopify reports. The supplied sales reports consolidate both simulated channels; filter Online Store to see only website sales.

## Sessions, page views and conversion

A session is one website visit. A visitor may visit more than once, and a session may view several pages. Pageviews measures those page views, not the number of visits or purchasers.

Online Store conversion percentage = 100 x sessions that completed checkout / total sessions.

eBay orders are excluded from website conversion. Each Online Store order is linked to exactly one successful session in this simplified scenario. eBay orders have blank session, device and website-referrer fields. Non-buying sessions have a blank order ID.

For a week, month or year, add converted-session counts and total-session counts first, then divide. Do not take a simple average of daily conversion percentages. Values ending in `_pct` are percentage points: 2.5 means 2.5%, not 250%.

Unique visitor counts are not additive. The same visitor can appear on several days or in several groups. Count distinct visitor_id values in website_sessions_2027.csv to obtain unique visitors over the full selected period. Monthly unique visitors were recalculated from sessions, not summed from daily reports.

Traffic is deliberately stored separately from item rows. An order with a service and kit still has only one converting visit. Joining sessions to item rows can duplicate pageviews; use order-level joins or deduplicate session IDs when combining these sources.

## Reporting scope

The reports follow selected Shopify metric definitions and grouping concepts. They are simplified, normalized practice CSVs, not byte-for-byte reproductions of Shopify native exports, and should not be imported into Shopify as real orders or products.

Sales reports include gross sales, discounts, sales reversals, net sales, quantities and relevant order counts. Discounts and reversals are explicitly assumed zero, preserving all previously agreed prices and completed orders. No tax, shipping revenue, payment fees, eBay fees or costs are modeled. Total sales and profit are deliberately not supplied because those additional inputs are missing. AOV is product sales after discounts divided by orders; it excludes taxes and shipping.

Real Shopify reports can have tracking gaps, multiple orders per session, visitors moving between devices, direct-checkout paths, reversals, attribution differences and disconnected marketplace data. This first practice dataset assumes complete website tracking and one order per converted session. Its funnel is closed and sequential: checkout follows cart addition, and purchase follows checkout. Synthetic visit IDs and their order links are an instructional extension, not a claim about fields available in a standard Shopify export.

TechRevive Performance Upgrade Bundles are modeled as their actual product variants. No Shopify Bundles-app component report is implied.

## Randomness and retained business assumptions

The original order IDs, dates, customer IDs, amounts, service selections and category counts were retained. The formerly consolidated same-price white refurbished source was split back across its two real SKUs without changing prices. Traffic and channel-assignment random seed: 20270926. Original sales-selection seed: 20270925.

Standard remains the leading repair tier, Apex Predator the leading bundle, and joysticks the leading repair add-on and standalone upgrade choice. The sales data contains 99 Standard, 45 Basic and 36 Full Tech Revival repairs; 27 Apex Predator, 12 Outbreak and 11 Patient Zero bundles; 119 repairs with joystick upgrades; and 45 joystick-only individual upgrade orders out of 80.

Premium releases begin January, March, May, July, September and November, with 15 units sold in each release month. Masterpiece releases have one unit each in June and December. Prices remain within the approved $350-$500 and $1,000-$2,000 ranges. This remains a full sell-out scenario, not a demand forecast.

Traffic is generated for all 365 dates, independently of daily order volume, using about 45 visits per day before random variation and seasonality. January-to-December traffic weights are 1.00, 0.85, 1.00, 0.90, 1.00, 1.00, 1.05, 1.00, 1.10, 1.15, 1.40 and 1.50. Weekends receive a 1.12 multiplier; daily lognormal noise uses sigma 0.24. The generated session count is floored at that day's Online Store orders so every website order has a session.

Device weights are Mobile 65%, Desktop 30%, Tablet 5%. Referrer weights are Direct 30%, Google 35%, Instagram 15%, Facebook 12%, Email campaign 8%. Converted sessions are assigned with device weights Mobile 1, Desktop 1.45, Tablet 0.9 and referrer weights Direct 1.2, Google 1, Instagram 0.75, Facebook 0.7, Email campaign 1.7. These are simulation choices, not measured channel effectiveness or evidence of actual email campaigns.

Among non-buying sessions, cart-add probability is 7.5%; conditional checkout probability is 45%. Successful sessions view 4-10 pages, checkout-only sessions 3-8, cart-only sessions 2-7. Other visits view 1-6 pages with weights 42, 27, 16, 8, 5, 2. Non-buying visits have an 18% chance of reusing a prior visitor ID. Repeat website buyers reuse their assigned visitor ID. These choices create the practice funnel and visitor behavior.

## Sources

- Current catalog: connected TechRevive Shopify catalog, checked September 25, 2026. Product-specific URLs are included in products.csv.
- Sales definitions: https://help.shopify.com/en/manual/reports-and-analytics/shopify-reports/report-types/default-reports/sales-report
- Conversion and funnel definitions: https://help.shopify.com/en/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports
- Sessions, visitors and pageviews: https://shopify.dev/docs/api/shopifyql/latest/schemas/sessions_and_behavior/sessions

No real customers, orders or website traffic were read. No Shopify settings, products, SKUs or orders were changed.
