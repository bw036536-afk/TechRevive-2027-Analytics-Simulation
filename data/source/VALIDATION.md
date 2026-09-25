# Validation of version 2

All checks below passed against the exported CSV files.

- 500 unique orders and 603 unique item rows; prior dates, customers, selections and amounts preserved.
- 78 eBay and 422 Online Store orders. All eBay orders are refurbished sales; the refurbished split is 78 eBay / 20 Online Store.
- Real Shopify product IDs, variant IDs, SKUs, titles, handles, vendor, source product types and statuses match the refreshed connected catalog exactly.
- All real catalog and transaction prices match the source variant prices. Genuine missing SKUs and hypothetical-release IDs remain blank.
- All five active refurbished source SKUs are retained separately.
- Catalog joins, order references and flat-file details reconcile. Every order subtotal equals its item sum.
- 18,847 unique website sessions across all 365 dates, including non-buying visits.
- Exactly 422 completed sessions link one-to-one to the 422 Online Store orders, on matching dates and dimensions.
- eBay orders have no website sessions and are excluded from every website conversion report.
- Funnel stages are internally consistent and pageviews are positive.
- Daily, monthly, device and referrer reports independently reconcile to session records, pageviews, distinct visitors and conversion counts.
- Every exported conversion percentage reconciles to its numerator and denominator within four-decimal rounding tolerance.
- Monthly, channel and SKU reports reconcile to order and item sales. AOVs and quantity counts match independent calculations.
- Premium releases contain 15 units in each approved release month; Masterpiece remains two units for the year. Dates and edition numbers respect release bounds.
- All 190 simulated physical retail units retain unique unit IDs.
- Standard remains the leading repair tier; Apex Predator remains the leading bundle. Original service selections are preserved.
- All 209 data-dictionary entries match their exported column names. CSV serialization preserves identifiers and blanks.

These checks establish consistency of the generated scenario, not the accuracy of the simulated demand, traffic or channel behavior as a business forecast.
