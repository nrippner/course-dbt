SELECT *
FROM {{ source('greenery_source', 'order_items') }}