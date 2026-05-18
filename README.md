# University Workshop Starter

## My Project

### Analytics Question
**Which customers generate the most gross profit for Jaffle Shop, and what does that tell us about who we should prioritize?**

### Project Structure
- `models/staging/` — cleans and standardizes raw source tables
- `models/intermediate/int_order_margins.sql` — joins orders, items, products, and supply costs to calculate gross profit per order
- `models/marts/fct_customer_profitability.sql` — rolls up revenue, gross profit, and order count per customer

### Insight
Customer profitability is not just about order count or revenue — it is driven by order size. Margin rates are consistent across customers at around 78-80%, meaning all customers buy similar product mixes. The real differentiator is how much customers spend per order.

- **Ryan Byrd** generates **$14,030 gross profit from just 2 orders** ($8,750 avg order size), making him the #1 most profitable customer
- **Christopher Kim** places the most orders in the dataset (10) but generates only **$4,295 gross profit** ($550 avg order size) — doesn't crack the top 30 by profit
- **Kristin Mcintyre** places 9 orders but contributes only $4,079 gross profit ($453 avg per order)

Ranking customers by revenue or order frequency alone misidentifies who actually drives business value.

### Actionable Next Step
Prioritize retention outreach for high-profit customers based on order value, not order frequency. Ryan Byrd and Douglas Hill together contribute over $26,000 in gross profit from just 8 combined orders — losing one of their orders costs more than losing 15 orders from a high-frequency, low-value customer. Investigate what products these customers buy per order to identify upsell opportunities for the broader customer base.

---

#### Intermediate (`models/intermediate/`)

Reusable joins / business logic:

- `int_sales_enriched`: items + orders + products + stores (+ supplies)
- `int_customer_orders`: customer order history + sequencing
- `int_item_finance`: item-level revenue/cost/margin fields

#### Marts (`models/marts/`)

Final models that answer your question(s):

- `dim_*` for entities (customer, product, store, date)
- `fct_*` for measurable events (order, sale line, daily rollups)

---
