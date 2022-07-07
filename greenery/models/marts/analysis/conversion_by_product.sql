SELECT 
    product_id
    , name
    , num_sessions_with_purchase::float
    / num_sessions_with_view * 100 AS percent_conversion_by_product
FROM {{ ref('fact_products') }}
ORDER by 4 DESC