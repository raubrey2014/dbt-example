with source as (
    
    select * from {{ ref('stg_listings') }}

),

final as (

    select
        COUNT(*) as listings_count,
        COUNT(DISTINCT sku) as unique_sku_count,
        SUM(absolute_price) as total_value

    from source

)

select * from final