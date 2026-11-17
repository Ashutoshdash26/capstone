with cte as(
select 
    *,
    row_number() over(partition by category order by total_gross_amount_per_gender_category desc) as deduplic
from 
    {{ source('source', 'extract_silver_data') }}
)

select * from cte 
where deduplic = 1