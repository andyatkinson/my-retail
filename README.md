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

`GET http://localhost:5000/api/products/{id}`

e.g. 15117729

`GET http://localhost:5000/api/products/13860428`

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
curl -X GET http://localhost:5000/api/products/13860428
```

### Updating product price

Make a put request to the following URL with the following JSON body as the payload.

Set the body to application/json.

PUT http://localhost:5000/api/products/13860428

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
  http://localhost:5000/api/products/13860428 \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
    "product": {
    	"id": 13860428,
    	"value": 17.50
    }
}
'
```


### Running the Application

To boot up the application on port 5000:

`rails s -p 5000`



## External Integrations

HTTP interaction with Redsky service
