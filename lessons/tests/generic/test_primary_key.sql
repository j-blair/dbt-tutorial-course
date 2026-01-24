{% test primary_key(model, column_name) %}

WITH validation AS(
    SELECT 
        {{ column_name }} AS primary_key,
        COUNT(1) AS occurrences
    
    FROM {{ model }}
    GROUP BY {{ column_name }}

)

SELECT *
FROM validation
WHERE primary_key is NULL OR occurrences > 1

{% endtest %}

{# 
{% test col_greater_than(model, column_name, value=0) %}

SELECT 
    {{ column_name }} AS row_that_failed
FROM {{ model }}
WHERE {{ column_name }} <= {{ value }}

{% endtest %} #}