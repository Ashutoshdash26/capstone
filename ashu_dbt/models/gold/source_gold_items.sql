with dedup_query as
(
select 
    *,
    row_number() over(partition by id order by Updatedate desc) as deduplication_id
from
    {{ source('source', 'items') }}

)

select 
    id,
    name,
    category,
    Updatedate
from
    dedup_query
where 
    deduplication_id = 1