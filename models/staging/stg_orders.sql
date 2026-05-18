with source as (

    select * from {{ source('jaffle_shop', 'raw_orders') }}

),

renamed as (

    select
        id as order_id,
        customer  as order_customer_id,
        ordered_at as order_ordered_at,
        store_id as order_store_id,
        subtotal as order_subtotal,
        tax_paid as order_tax_paid,
        order_total as order_total

    from source

)

select * from renamed