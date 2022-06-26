{{
  config(
    materialized='table'
  )
}}

SELECT 
    created_at::date as order_date_utc,
    product_id,
    name,
    sum(quantity) as n_items_ordered,
    sum(order_cost) as total_cost,
    sum(shipping_cost) as total_shipping_cost,
    sum(discount) as total_discount
FROM 
    {{ ref('stg_orders') }} 
    join {{ ref('stg_order_items') }} using(order_id)
    join {{ ref('stg_products') }} using(product_id)
    join {{ ref('stg_promos') }} using(promo_id)
GROUP BY 1, 2, 3