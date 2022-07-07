# What is our overall conversion rate?

```
SELECT  
  SUM(CASE WHEN conversion = TRUE THEN 1 ELSE 0 END)::float 
  / count(*) * 100 AS percent_overall_conversion
FROM {{ ref('fact_sessions') }}
```

62.45674740484429

# What is our conversion rate by product?

```
SELECT 
    product_id
    , name
    , num_sessions_with_purchase::float
    / num_sessions_with_view * 100 AS percent_conversion_by_product
    FROM {{ ref('fact_products') }}
    ORDER by 4 DESC
    ```

