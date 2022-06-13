SELECT *
FROM {{ source('greenery_source', 'orders') }}