# dataflow
The data pipeline follows the Data Vault 2.0 methodology for data warehouse architecture.

## dbt Data Vault 2.0 pipeline (BigQuery)

Layers:
- `models/staging/{streaming,mysql}/base/base__*` – views over `raw` sources
- `models/intermediate/stage/stg__*` – AutomateDV staging (hash keys, link keys, hashdiffs, record_source, load_datetime)
- `models/intermediate/data_vault/{hub,link,sat}` – incremental raw vault
- `models/information_marts/sales/daily/fct/fct__sales_daily_channel_summary` – daily revenue / receipts / customers per channel

Setup: set `DBT_PROJECT_PROFILE=local`, `GCP_PROJECT_ID`, `DBT_DATASET_NAME`, run `gcloud auth application-default login`, then `dbt deps && dbt build`.
