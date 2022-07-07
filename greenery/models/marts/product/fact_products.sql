{{
  config(
    materialized='table'
  )
}}

WITH conversions_by_session AS ( 
    SELECT DISTINCT
        session_id
        , oi.product_id
        , quantity as num_purchased
    FROM {{ ref('stg_order_items') }} oi
    LEFT JOIN {{ ref('stg_events') }} 
    USING (order_id)
),
views_by_session AS (
    SELECT 
        session_id
        , product_id
        , count(*) as num_views
    FROM {{ ref('stg_events') }}
    WHERE event_type = 'page_view'
    GROUP BY 1,2
),
joined AS (
    SELECT *
    FROM conversions_by_session
    FULL OUTER JOIN views_by_session 
    USING(session_id, product_id)
    JOIN {{ ref('stg_products') }}
    USING (product_id)
),
agg_views AS (
    SELECT
        product_id
        , name
        , count(DISTINCT session_id) as num_sessions_with_view
    FROM joined
    WHERE num_views > 0
    GROUP BY 1,2
),
agg_conversions AS (
    SELECT
        product_id
        , name
        , count(DISTINCT session_id) as num_sessions_with_purchase
    FROM joined
    WHERE num_purchased > 0
    GROUP BY 1,2
)
SELECT *
FROM agg_views
FULL OUTER JOIN agg_conversions
USING (product_id, name)


