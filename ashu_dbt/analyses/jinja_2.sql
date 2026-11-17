{%- set apple=['Gala','Fuji','Honeycrisp','Granny Smith','Red Delicious'] -%}

{% for i in apple %}

   {% if i != 'Gala' %}
        {{ i }}
   {% else %}
        i hate {{ i }} 
   {% endif %}
{% endfor %}