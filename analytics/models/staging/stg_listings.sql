with source as (

    select * from {{ ref('raw_listings') }}

),

enriched as (

    select
        *,
        {{ absolute_price('price', 'price_unit', 'quantity', 'quantity_unit') }} as absolute_price,

    from source

)

select * from enriched