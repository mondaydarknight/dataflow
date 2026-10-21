{{ config(tags=["manually"]) }}

with
    source as (select * from {{ source("raw", "streaming_event_receipt_finalized") }}),
    renamed as (
        select
            {{ adapter.quote("id") }} as receipt_id,
            {{ adapter.quote("member_id") }},
            {{ adapter.quote("receipt_number") }},
            {{ adapter.quote("currency") }},
            {{ adapter.quote("items") }},
            {{ adapter.quote("total_amount") }},
            {{ adapter.quote("seller_tax_id") }},
            {{ adapter.quote("created_at") }},
            {{ adapter.quote("issued_at") }},
            {{ adapter.quote("load_datetime") }}
        from source
    )
select *
from renamed
