# My Retail

## Install

Tested on OS X.
Native dependencies:
readline

`brew install readline`

Install Postgres.

Install ruby. Tested with 2.4.1. rbenv used to manage Ruby versions. Install bundler gem, which will manage all other gems installed.

`bundle`


#### Create databases

A number of ways to do this, one way is from a `psql` prompt, run:

```sql
create database my_retail_dev;
create database my_retail_test;
```

`rake db:migrate`

Load data
`rake db:seed`

Confirm data is loaded (example, may change):

```
# \c my_retail_dev
You are now connected to database "my_retail_dev" as user "andy".
andy@[local]:5432 my_retail_dev# select * from products;
 id | external_id | price_details |         created_at         |         updated_at
----+-------------+---------------+----------------------------+----------------------------
  1 |    15117729 |               | 2018-02-15 18:19:19.761739 | 2018-02-15 18:19:19.761739
  2 |    16483589 |               | 2018-02-15 18:19:19.765197 | 2018-02-15 18:19:19.765197
  3 |    16696652 |               | 2018-02-15 18:19:19.767898 | 2018-02-15 18:19:19.767898
  4 |    16752456 |               | 2018-02-15 18:19:19.770103 | 2018-02-15 18:19:19.770103
  5 |    15643793 |               | 2018-02-15 18:19:19.772462 | 2018-02-15 18:19:19.772462
(5 rows)
```

e.g.

```sql
 select price_details->'current_price'->'value' as value, price_details->'current_price'->'currency_code' as currency from products where external_id = 13860428;
 value | currency
-------+----------
 13.49 | "USD"
```

## Overview

The Product resource has an ID and price details. The price details contain fields of data to manage pricing, and stored in a schemaless data store.

## API Testing

Using something like Postman, make the following HTTP request.

GET localhost:5000/api/products/{id}

e.g. 15117729

GET localhost:5000/api/products/15117729

Response (e.g.):

```
{"id":15117729,"name":"The Big Lebowski (Blu-ray) (Widescreen)","current_price":{"value": 13.49,"currency_code":"USD"}}
```



## External Integrations

HTTP interaction with Redsky service.
