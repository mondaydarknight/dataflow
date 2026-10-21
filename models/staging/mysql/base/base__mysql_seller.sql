{{ config(tags=["manually"]) }}

with
    source as (select * from {{ source("raw", "mysql_seller") }}),
    renamed as (
        select
            {{ adapter.quote("tax_id") }},
            {{ adapter.quote("channel_id") }},
            {{ adapter.quote("name") }},
            {{ adapter.quote("address") }},
            {{ adapter.quote("created_at") }},
            {{ adapter.quote("updated_at") }},
            {{ adapter.quote("load_datetime") }}
        from source
    )
select *
from renamed
