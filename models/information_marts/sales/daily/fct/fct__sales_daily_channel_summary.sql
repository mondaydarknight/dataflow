{{ config(tags=["daily"]) }}

with
    sat__receipt as (
        select *
        from {{ ref("sat__receipt") }}
        qualify
            row_number() over (partition by receipt_hk order by load_datetime desc)
            = 1
    ),
    link__receipt_user as (select * from {{ ref("link__receipt_user") }}),
    link__receipt_seller as (select * from {{ ref("link__receipt_seller") }}),
    link__channel_seller as (select * from {{ ref("link__channel_seller") }}),
    fct as (
        select
            l3.channel_hk,
            date(s1.issued_at) as issued_at,
            sum(s1.total_amount) as revenue,
            count(distinct s1.receipt_hk) as unique_receipt_count,
            count(distinct l1.user_hk) as unique_customer_count
        from sat__receipt as s1
        join link__receipt_user as l1 on s1.receipt_hk = l1.receipt_hk
        join link__receipt_seller as l2 on s1.receipt_hk = l2.receipt_hk
        join link__channel_seller as l3 on l2.seller_hk = l3.seller_hk
        group by l3.channel_hk, date(s1.issued_at)
    )
select *
from fct
