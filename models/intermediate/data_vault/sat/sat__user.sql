{{
    config(
        partition_by={
            "field": "effective_from",
            "data_type": "datetime",
            "granularity": "day",
        },
        require_partition_filter=false,
        tags=["manually"],
    )
}}

{%- set yaml_metadata -%}

source_model: "stg__user"
src_pk: "user_hk"
src_hashdiff:
  source_column: "user_hashdiff"
  alias: "hashdiff"
src_payload:
    - "email"
    - "username"
    - "phone_number"
    - "status"
    - "gender"
    - "created_at"
    - "updated_at"
src_eff: "effective_from"
src_ldts: "load_datetime"
src_source: "record_source"

{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{
    automate_dv.sat(
        src_pk=metadata_dict["src_pk"],
        src_hashdiff=metadata_dict["src_hashdiff"],
        src_payload=metadata_dict["src_payload"],
        src_eff=metadata_dict["src_eff"],
        src_ldts=metadata_dict["src_ldts"],
        src_source=metadata_dict["src_source"],
        source_model=metadata_dict["source_model"],
    )
}}
