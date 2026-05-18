with source as (

    select * from {{ source('jaffle_shop', 'raw_stores') }}

),

renamed as (

    select
        id as store_id,
        name as store_name,
        opened_at as store_opened_at,
        tax_rate as store_tax_rate

    from source

)

select * from renamed