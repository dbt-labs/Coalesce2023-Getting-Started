1. Click on the "..." next to the folder and select "New File". Be sure
to include the ".yml" extension. Feel free to copy & paste

2. Your YAML file should mirror the below. If you are receiving compilation errors,
be sure to check the indentation. Also, be sure that your transformed column names from the
staging layer are the same in your "_schema_jaffle_shop.yml" file. Copy & paste is encouraged with YAML.

--------
-- file: models/staging/_schema_jaffle_shop.yml
--------
version: 2

models:
  - name: stg_jaffle_shop__customers
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
  - name: stg_jaffle_shop__orders
    columns:
      - name: order_id
        tests:
          - unique
          - not_null
      - name: status
        tests:
          - accepted_values:
              values: ['placed', 'shipped', 'completed', 'returned', 'return_pending']
      - name: customer_id
        tests:
          - relationships:
              to: ref('stg_jaffle_shop__customers')
              field: customer_id

3. dbt test
