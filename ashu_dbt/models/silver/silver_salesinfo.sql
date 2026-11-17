with sales as(
    select 
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price','quantity' ) }} as calculated_gross_amount,
        gross_amount,
        payment_method
    from 
        {{ ref("bronze_salses") }}
),
 products as (
    select 
        product_sk,
        category
    from 
        {{ ref("bronze_product") }}
),
customer as(
    select 
        customer_sk,
        gender
    from 
        {{ ref("bronze_customer") }}

    
),
cte as(
select 
    sales.sales_id,
    products.category,
    customer.gender,
    sales.calculated_gross_amount,
    sales.gross_amount,
    sales.payment_method
from 
    sales
join 
    products on sales.product_sk = products.product_sk
join 
    customer on sales.customer_sk = customer.customer_sk
)

select gender,category,sum(gross_amount) as total_gross_amount_per_gender_category,
dense_rank() over(partition by category order by sum(gross_amount) desc) as rank_per_category
from cte 
group by gender,category
order by category , gender,total_gross_amount_per_gender_category