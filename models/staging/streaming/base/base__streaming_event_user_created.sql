{{ config(tags=["manually"]) }}

with
    source as (select * from {{ source("raw", "streaming_event_user_created") }}),
    renamed as (
        select
            {{ adapter.quote("id") }} as user_id,
            {{ adapter.quote("email") }},
            {{ adapter.quote("username") }},
            {{ adapter.quote("phone_number") }},
            {{ adapter.quote("status") }},
            {{ adapter.quote("gender") }},
            {{ adapter.quote("created_at") }},
            {{ adapter.quote("updated_at") }},
            {{ adapter.quote("load_datetime") }}
        from source
    )
select *
from renamed
