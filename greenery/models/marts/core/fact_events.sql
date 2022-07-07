{{
  config(
    materialized='table'
  )
}}


{% set event_types = dbt_utils.get_column_values(
    table=ref('stg_events'),
    column='event_type'
) %}

SELECT
    p.product_id
    {% for event in event_types %}
    , count(*) AS {{event}}_counts
    {% endfor %}
FROM {{ ref('stg_products') }} p
LEFT JOIN {{ ref('stg_events') }}
USING (product_id)
GROUP BY 1