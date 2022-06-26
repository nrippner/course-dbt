{{
  config(
    materialized='table'
  )
}}

WITH total_pageviews as (
    SELECT 
        date_utc,
        sum(pageviews) as pageviews
    FROM {{ ref('int_daily_users') }} 
    GROUP BY 1
)
SELECT *
FROM total_pageviews

