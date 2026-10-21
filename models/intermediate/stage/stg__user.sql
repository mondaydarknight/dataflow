{{ config(tags=["manually"]) }}

{%- set yaml_metadata -%}

source_model: "base__streaming_event_user_created"

derived_columns:
  record_source: "!base__streaming_event_user_created"
  load_datetime: "load_datetime"
  effective_from: "updated_at"

hashed_columns:
    user_hk: "user_id"

    user_hashdiff:
        is_hashdiff: true
        columns:
        - "email"
        - "username"
        - "phone_number"
        - "status"
        - "gender"
        - "created_at"
        - "updated_at"

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{
    automate_dv.stage(
        include_source_columns=true,
        source_model=metadata_dict["source_model"],
        derived_columns=metadata_dict["derived_columns"],
        null_columns=none,
        hashed_columns=metadata_dict["hashed_columns"],
        ranked_columns=none,
    )
}}
