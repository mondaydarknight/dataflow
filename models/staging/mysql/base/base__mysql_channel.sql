{{ config(tags=["manually"]) }}

with
    source as (select * from {{ source("raw", "mysql_channel") }}),
    renamed as (
        select
            {{ adapter.quote("id") }} as channel_id,
            {{ adapter.quote("name") }},
            {{ adapter.quote("created_at") }},
            {{ adapter.quote("updated_at") }},
            {{ adapter.quote("load_datetime") }}
        from source
    )
select *
from renamed
