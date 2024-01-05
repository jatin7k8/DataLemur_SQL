-- Highest-Grossing Items [Amazon SQL Interview Question]
with cte AS
(
SELECT 
category,product, spend,
  sum(spend) over(PARTITION BY category , product order by spend DESC) as total_spend
FROM  
  product_spend
WHERE 
  EXTRACT(year FROM transaction_date) = 2022
  order by 1 ASC, 3 DESC
), cte2 as 
(
select 
category,product, MAX(total_spend) as total_spend
from cte
group by 1, 2
order by 3 DESC
) ,c3 as 
(
select
*,
rank() over(PARTITION BY category order by total_spend DESC) as rnk
from cte2
)

SELECT 
category,product, total_spend
FROM c3 
WHERE rnk <= 2
