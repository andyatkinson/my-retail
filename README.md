# My Retail

## Installation instructions

Notes: Tested on OS X with Ruby, managed by rbenv. Homebrew installed native dependencies, e.g. readline, postgres (tested with 9.5.4)

`brew install readline`

Install ruby. Tested with 2.4.1. rbenv used to manage Ruby versions. Install bundler gem, which will manage all other gems installed.

`bundle`

Once the application gems are installed, running `rake` will run the build, and should be an additional verification point that everything is set up.


#### Create databases

There are a number of ways to do this, one way is from a `psql` prompt, run:

```sql
create database my_retail_dev;
create database my_retail_test;
```

To create the database schema:

`rake db:migrate`

To load data into the database using the Rails seeds functionality:

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

The Product resource has an ID and price details, stored as JSON data, using the jsonb column type.

## API Testing

### Fetch product details

Using Postman or curl, make the following HTTP requests.

`GET http://localhost:5000/products/{id}`

e.g. 15117729

`GET http://localhost:5000/products/13860428`

Response (e.g.):

```
{
    "id": 13860428,
    "name": "The Big Lebowski (Blu-ray)",
    "current_price": {
        "value": 13.49,
        "currency_code": "USD"
    }
}
```

##### Curl request

```
curl -X GET http://localhost:5000/products/13860428
```

### Updating product price

Make a put request to the following URL with the following JSON body as the payload.

Set the body to application/json.

PUT http://localhost:5000/products/13860428

```
{
    "product": {
      "id": 13860428,
      value": 17.50
    }
}
```

#### Curl request

```
curl -X PUT \
  http://localhost:5000/products/13860428 \
  -H 'content-type: application/json' \
  -d '{
    "product": {
    	"id": 13860428,
    	"value": 17.50
    }
}
'
```

#### Production Curl Request examples

```
curl -X PUT \
  https://limitless-oasis-33699.herokuapp.com/products/13860428 \
  -H 'content-type: application/json' \
  -d '{
    "product": {
    	"id": 13860428,
    	"value": 17.29
    }
}
'
```


```
curl -X GET https://limitless-oasis-33699.herokuapp.com/products/13860428
```


### Running the Application

To boot up the application on port 5000:

`rails s -p 5000`

Or:

`foreman start`

## Benchmarking

TODO

## External Integrations

HTTP interaction with Redsky service


## Additional Performance Improvements (future)

#### Cache the Redsky service calls periodically, TTL of 1 minute

As requests for product IDs come in, we could cache the response with a key of the product ID, and the value as the JSON string, e.g. in memcached or another key-value store, and then for subsequent requests for the same ID, server the JSON string from the cache store and not make a live HTTP call.

We could specify a period of time that the cached response is fresh, e.g. 1 minute (the TTL).

#### Optimize JSON serialization

Benchmark various JSON serialization options.

#### Consider a slim API response variant

Using a parameter, a client could request a reduced set of attributes that represent the object. For example, in a mobile app on a summary screen, a trade-off for a faster summary screen could be fetching fewer attributes for each row, which would take less time to serialize, and produce a smaller JSON payload.
