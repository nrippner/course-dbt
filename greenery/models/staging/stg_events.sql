SELECT *
FROM {{ source('greenery_source', 'events') }}