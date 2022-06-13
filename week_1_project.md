1. How many users do we have?
2. On average, how many orders do we receive per hour?
3. On average, how long does an order take from being placed to being delivered?
4. How many users have only made one purchase? Two purchases? Three+ purchases?            
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase
5. On average, how many unique sessions do we have per hour?

1. 130
2. 7.5
3. 93.4 hours
4. 1 order: 25; 2 orders: 28; >2 orders: 71
5. 16.3


Addendum:

-- with unique_sessions_per_hour as (
-- select date_trunc('hour', created_at) as hour, 
--       count(distinct session_id) as n_sessions 
--     from stg_events 
--     group by hour
--     )
--   select (select sum(n_sessions) from unique_sessions_per_hour) / (select count(*) from unique_sessions_per_hour)



-- with agged as (
-- select user_id, count(*) as n 
-- from stg_orders
-- group by user_id 
-- )
-- select sum(case when n=1 then 1 else 0 end) as one_order,
--         sum(case when n=2 then 1 else 0 end) as two_orders,
--         sum(case when n>2 then 1 else 0 end) as more_than_two 
--   from agged



-- with time_diff as (
-- select date_part('day', delivered_at - created_at) * 24 +
--         date_part('hour', delivered_at - created_at) as delivery_time
-- from stg_orders
-- where delivered_at is not null
-- )
-- select (select sum(delivery_time) from time_diff) / (select count(*) from time_diff)




-- with orders_per_hour as (
--   select date_trunc('hour', created_at) as hour, count(*) n
--   from stg_orders
--   group by hour
-- )

-- select (select sum(n) from orders_per_hour) / (select count(*) from orders_per_hour)




