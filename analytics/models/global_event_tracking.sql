with manual_tracking as (

    select
        concat(first_name, last_name) as name,
        event,
        timestamp as date
        
    from {{ source('google_sheets', 'test_tracker') }}

),

listings_tracking as (

    select
        purchaser as name,
        'listing_purchase' as event,
        date

    from {{ ref('stg_listings') }}

),

final as (
    select * from manual_tracking

    union all

    select * from listings_tracking
)

select * from final