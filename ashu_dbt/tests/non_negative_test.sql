select 
       *
   from 
       {{ ref('bronze_salses') }}
   where 
       gross_amount < 0 and net_amount < 0
