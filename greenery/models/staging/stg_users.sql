SELECT *
FROM {{ source('greenery_source', 'users') }}