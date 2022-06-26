What is our user repeat rate?

```with users_two_or_more as (
select count(*) n_two_or_more, 'extra' as extra from (
        select user_id, count(distinct order_id)
        from orders 
        group by 1
        having count(distinct order_id) >= 2
        ) sub_query
),
all_users as (
select count(distinct user_id) n_all,'extra' as extra
from orders
),
joined as (
select n_two_or_more, n_all 
from users_two_or_more 
join all_users using(extra)
)
select  n_two_or_more::float / n_all * 100 from joined```

### 79.83870967741935