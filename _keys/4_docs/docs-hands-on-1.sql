1. Add a "description: " field directly below each model and column identified in your
"_schema_jaffle_shop.yml" file

--------
-- file: models/staging/_schema_jaffle_shop.yml
--------
version: 2

models:
  - name: stg_jaffle_shop__customers
    description: 
    columns:
      - name: customer_id
        description: 
        tests:
          - unique
          - not_null
  - name: stg_jaffle_shop__orders
    description: 
    columns:
      - name: order_id
        description: 
        tests:
          - unique
          - not_null
      - name: status
        description: 
        tests:
          - accepted_values:
              values: ['placed', 'shipped', 'completed', 'returned', return_pending]
      - name: customer_id
        description: 
        tests:
          - relationships:
              to: ref('stg_jaffle_shop__customers')
              field: customer_id

2. Create a markdown file called doc_blocks.md in the staging directory. Use this
file to document the status field in the stg_jaffle_shop__orders.sql models

--------
-- file: models/staging/doc_blocks.md
--------
{% docs order_status %}

One of the following values:

| status         | definition                                                 |
|----------------|------------------------------------------------------------|
| placed         | Order placed but not yet shipped                           |
| shipped        | Order has been shipped but has not yet been delivered      |
| completed      | Order has been received by customers                       |
| return_pending | Customer has indicated they would like to return this item |
| returned       | Item has been returned                                     |

{% enddocs %}

3. Replace the longform description in the "_schema_jaffle_shop.yml" file with the docs block function

--------
-- file: models/staging/_schema_jaffle_shop.yml
--------
- name: status
  description: "{{ doc('order_status') }}"

4. dbt docs generate

