{{
  config(
    materialized='table'
  )
}}

SELECT
    date_utc,
    pageviews
FROM {{ ref('int_pageviews') }}