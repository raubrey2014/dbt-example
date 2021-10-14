{% macro get_conversion_matrix() %}
    {{ return({ 'lb': 1, 'kg': 2.2046226218488, 'mt': 2204.62262, 'nt': 2000, 'gt': 2240 }) }}
{% endmacro %}

{% macro get_rate_in_lbs(rate, rate_unit) %}
    {% set matrix = get_conversion_matrix() %}
    case
    {% for key in matrix %}
        when {{ rate_unit }} = '{{ key }}' then ({{ rate }} / {{ matrix[key] }})
    {% endfor %}
        else null
    end
{% endmacro %}

{% macro get_quantity_in_lbs(quantity, quantity_unit) %}
    {% set matrix = get_conversion_matrix() %}
    case
    {% for key in matrix %}
        when {{ quantity_unit }} = '{{ key }}' then ({{ quantity }} * {{ matrix[key] }})
    {% endfor %}
        else null
    end
{% endmacro %}

{% macro absolute_price(rate, rate_unit, quantity, quantity_unit) %}
    case
        when ({{ rate }} is null or {{ quantity }} is null or {{ rate_unit }} is null or {{ quantity_unit }} is null) then null
        when {{ rate_unit }} = {{ quantity_unit }} then {{ rate }} * {{ quantity }}
        else round({{ get_quantity_in_lbs(quantity, quantity_unit) }} * {{ get_rate_in_lbs(rate, rate_unit) }}, 5)
    end
{% endmacro %}