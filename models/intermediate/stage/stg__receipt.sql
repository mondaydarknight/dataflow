{{ config(tags=["manually"]) }}

{%- set yaml_metadata -%}

source_model: "base__streaming_event_receipt_finalized"

derived_columns:
  record_source: "!base__streaming_event_receipt_finalized"
  load_datetime: "load_datetime"
  effective_from: "issued_at"
  items_json: "TO_JSON_STRING(items)"

hashed_columns:
    receipt_hk: "receipt_id"

    user_hk: "member_id"

    seller_hk: "seller_tax_id"

    receipt_user_hk:
        - "receipt_id"
        - "member_id"

    receipt_seller_hk:
        - "receipt_id"
        - "seller_tax_id"

    receipt_hashdiff:
        is_hashdiff: true
        columns:
        - "receipt_number"
        - "currency"
        - "items_json"
        - "total_amount"
        - "created_at"
        - "issued_at"

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
