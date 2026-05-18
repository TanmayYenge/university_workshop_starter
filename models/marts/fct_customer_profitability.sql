with customer_orders as (

    select * from {{ ref('int_order_margins') }}

),

customers as (

    select * from {{ ref('stg_customers') }}

),

final as (

    select
        customers.customer_id as customer_id,
        customers.customer_name as customer_name,

        count(customer_orders.order_id) as total_orders,

        coalesce(sum(customer_orders.order_revenue), 0) as total_revenue,
        coalesce(sum(customer_orders.order_supply_cost), 0) as total_supply_cost,
        coalesce(sum(customer_orders.order_gross_profit), 0) as total_gross_profit,

        coalesce(avg(customer_orders.order_gross_profit), 0) as avg_order_gross_profit

    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.order_customer_id

    group by
        customers.customer_id,
        customers.customer_name

)

select * from final