{{
  config(
    materialized='table'
  )
}}

SELECT e.created_at::date as date_utc, 
       user_id,
       count(distinct page_url) as pageviews,
       count(distinct e.order_id) as orders,
       sum(order_cost) as total_cost
FROM {{ ref('stg_events') }} e 
  JOIN {{ ref('stg_orders') }} 
  USING (user_id, order_id) 
GROUP BY 1, 2 