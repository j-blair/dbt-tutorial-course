{{ config(
   severity='warn') }}

{# config(error_if=">1") another config option #}

{# using ref, this test will run when either model runs #}

WITH order_details AS (
    SELECT
        order_id,
        COUNT(*) AS number_of_items_in_order

    FROM {{ ref('stg_ecommerce__order_items') }}
    GROUP BY 1
)

SELECT
    {# return whatever columns you want, all items in orders and order details #}
    o.*,
    od.*
    {# if you want to ignore this test related to the stg_ecommerce__orders table,
    FROM dbt_test.stg_ecommerce__orders or
    {{ target.schema }}.stg_ecommerce__orders
     #}
FROM {{ ref('stg_ecommerce__orders') }} o
FULL OUTER JOIN order_details od USING (order_id)
WHERE o.order_id IS NOT NULL 
OR od.order_id IS NOT NULL
OR o.num_items_ordered != od.number_of_items_in_order