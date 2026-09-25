# TechRevive 2027 | Sales & Website Analytics

**Status: In progress**  
**Dataset: Simulated 2027 activity using TechRevive catalog references**

An ecommerce analytics portfolio project exploring sales, product performance, and website conversion for a controller repair, upgrade, and refurbishment business. The project is being developed in Power BI, with space to add SQL queries and documented findings as the analysis progresses.

## Business questions

- How do sales and order volume vary across months?
- How do Online Store and eBay sales compare?
- Which products and services contribute the most sales?
- How does website conversion vary over time, by device, and by traffic source?

These are project questions, not conclusions about actual TechRevive performance.

## Data and transparency

All orders, customer identifiers, and website activity in this dataset are fictional. The dataset was generated with AI assistance for practice. Its documentation records real TechRevive catalog titles, prices, SKUs, and product identifiers checked on September 25, 2026. Premium and Masterpiece releases are hypothetical.

The 2027 dates describe a practice scenario. This project is not a forecast or a report of actual business results. Some patterns were deliberately built into the simulation; finding those patterns does not establish real customer behavior.

The supplied version 2 dataset contains:

| Source file | What one row represents |
| --- | --- |
| `orders_2027.csv` | One order |
| `order_items_2027.csv` | One item within an order |
| `sales_2027_flat.csv` | One item with its order and catalog details |
| `products.csv` | One catalog reference or hypothetical release |
| `releases_2027.csv` | One hypothetical limited release |
| `website_sessions_2027.csv` | One simulated website visit |
| `website_traffic_daily_2027.csv` | One day of website activity |

See the [dataset documentation](data/source/README.md), [data dictionary](data/source/data_dictionary.csv), and [report definitions](data/source/REPORT_GUIDE.md) for source assumptions and column meanings.

## Current progress

- Version 2 practice data and its documentation are included.
- Power BI report development has started, including slicers.
- The Power BI file, report screenshots, and completed SQL queries have not yet been added to this repository.
- Findings and recommendations will be documented after the calculations and report are checked.

## Repository layout

```text
data/source/       Supplied version 2 data, documentation, and example reports
sql/               SQL queries as they are completed
power-bi/          Power BI report file when ready to share
images/            Report screenshots when ready to share
```

The CSV reports in `data/source/reports/` were supplied with the generated dataset as reference outputs. They are not presented as independently completed portfolio analysis. The included source `VALIDATION.md` records the dataset preparation checks, not validation of the developing Power BI report.

## Measurement rules

- Count distinct order IDs when using the flat sales file: an order can have several item rows.
- Use item amounts for item-level sales. Do not sum repeated order totals across item rows.
- Calculate website conversion as converted sessions divided by total sessions. Exclude eBay orders from website conversion.
- For a month or year, divide the summed converted-session count by the summed session count rather than averaging daily conversion rates.
- Inspect blank values before removing records. Some missing SKU, device, and referrer values are intentional.
- Keep traffic and sales at appropriate levels of detail so joins do not duplicate visits or sales.

Costs, marketplace fees, taxes, and shipping are not modeled. The dataset supports sales analysis; it does not support a complete profit calculation.

## Working with the files

Download or clone this repository and read `data/source/README.md` first. The flat sales CSV provides an accessible starting point for sales analysis. Website traffic is stored separately for conversion analysis. The detailed orders, items, and products files support relational modeling.

Completed queries, dashboard screenshots, and instructions for reproducing the finished report will be added as the project develops.
