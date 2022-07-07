{{
  config(
    materialized='table'
  )
}}

WITH sessions_with_checkout AS (
    SELECT DISTINCT
        session_id
        , order_id
        , TRUE AS conversion
    FROM {{ ref('stg_events') }}
    WHERE event_type = 'checkout'
),
sessions_without_checkout AS (
    SELECT DISTINCT
        session_id
        , order_id
        , FALSE AS conversion
    FROM {{ ref('stg_events') }}
    WHERE session_id NOT IN (
                              SELECT
                                session_id
                              FROM sessions_with_checkout
                            )
),
unioned AS (
    SELECT *
    FROM sessions_with_checkout
    UNION
    SELECT *
    FROM sessions_without_checkout
)

SELECT
    session_id
    , u.order_id
    , conversion
    , count(e.*) AS num_pageviews
FROM unioned u
JOIN {{ ref('stg_events') }} e 
USING (session_id)
GROUP BY 1,2,3