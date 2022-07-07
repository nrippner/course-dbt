SELECT  
  SUM(CASE WHEN conversion = TRUE THEN 1 ELSE 0 END)::float 
  / count(*) * 100 AS percent_overall_conversion
FROM {{ ref('fact_sessions') }}