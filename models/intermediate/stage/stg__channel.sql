{{ config(tags=["manually"]) }}

{%- set yaml_metadata -%}

source_model: "base__mysql_channel"

derived_columns:
  record_source: "!base__mysql_channel"
  load_datetime: "load_datetime"
  effective_from: "updated_at"

hashed_columns:
    channel_hk: "channel_id"

    channel_hashdiff:
        is_hashdiff: true
        columns:
        - "name"
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
