{{
  config(
    materialized='table'
  )
}}

SELECT 
    date_utc,
    user_id,
    first_name,
    last_name,
    pageviews,
    orders,
    total_cost
FROM {{ ref('int_daily_users') }}
  JOIN {{ ref('stg_users') }}
  USING(user_id)
