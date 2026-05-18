with orders as (

    select * from {{ ref('stg_orders') }}

),

items as (

    select * from {{ ref('stg_items') }}

),

products as (

    select * from {{ ref('stg_products') }}

),

product_costs as (

    select
        supply_sku,
        sum(supply_cost) as total_supply_cost
    from {{ ref('stg_supplies') }}
    group by supply_sku

),

item_margins as (

    select
        items.item_order_id,
        items.item_sku,
        products.product_price,
        coalesce(product_costs.total_supply_cost, 0) as product_cost,
        products.product_price - coalesce(product_costs.total_supply_cost, 0) as item_margin

    from items
    left join products
        on items.item_sku = products.product_sku
    left join product_costs
        on items.item_sku = product_costs.supply_sku

),

final as (

    select
        orders.order_id,
        orders.order_customer_id,
        orders.order_ordered_at,
        orders.order_total,
        sum(item_margins.product_price) as order_revenue,
        sum(item_margins.product_cost) as order_supply_cost,
        sum(item_margins.item_margin) as order_gross_profit

    from orders
    left join item_margins
        on orders.order_id = item_margins.item_order_id

    group by
        orders.order_id,
        orders.order_customer_id,
        orders.order_ordered_at,
        orders.order_total

)

select * from final