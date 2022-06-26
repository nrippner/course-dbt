{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_date_utc,
    product_id,
    name,
    n_items_ordered,
    total_cost,
    total_shipping_cost,
    total_discount
FROM {{ ref('int_daily_orders') }}