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
