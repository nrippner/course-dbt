SELECT *
FROM {{ source('greenery_source', 'products') }}