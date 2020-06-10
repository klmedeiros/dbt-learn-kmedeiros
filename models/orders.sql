with orders as (

    select * from {{ ref('stg_orders') }}

),

payment as (

   select 
    order_id,
    sum(amount) as amount

    from stg_payment
    where status = 'success'
    group by order_id

),


final as (

    select 
        orders.customer_id,
        payment.order_id,
        orders.order_date,
        amount
    
    from payment

    left join orders using(order_id)
)

select * from final


