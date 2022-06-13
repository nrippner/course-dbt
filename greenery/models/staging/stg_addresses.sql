SELECT *
FROM {{ source('greenery_source', 'addresses') }}