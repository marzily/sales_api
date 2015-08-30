# rales_engine
http://rales-engine-m.herokuapp.com/

This project used Rails and ActiveRecord to build a JSON API.


## API Design

* All endpoints return JSON data
* All endpoints are exposed under an api and version (v1) namespace (e.g. /api/v1/merchants.json)


## Schema and Data Importing

* ActiveRecord models exist for each entity included in the sales engine data
* Application includes a rake task which ingests all of the CSV's and creates the appropriate records

### Data Object Models:

* Merchants
* Invoices
* Items
* Invoice Items
* Customers
* Transactions


## Endpoints


All data objects have the search functionality defined below.
Merchants has been used as an example.

### Random

`/api/v1/merchants/random.json`

Returns a random merchant

### Show Record

`/api/v1/merchants/(:id).json`
Renders a JSON representation of the appropriate record based on the ID number entered at (:id)

### Single Finders

Each data category offers finders to return a single object representation:

`/api/v1/merchants/find?id=(:id)`

Returns one merchant with the associated ID number entered at (:id). The "id" search parameter can be replaced with any of the attributes defined on the data type and is case insensitive.

Attributes for each data object can be accessed via the paths listed below:

```
Customers:
  /api/v1/customers/find?id=(:id)
  /api/v1/customers/find?first_name=(:first_name)
  /api/v1/customers/find?last_name=(:last_name)
  /api/v1/customers/find?created_at=(:created_at)
  /api/v1/customers/find?updated_at=(:updated_at)

Invoices:
  /api/v1/invoices/find?id=(:id)
  /api/v1/invoices/find?customer_id=(:customer_id)
  /api/v1/invoices/find?merchant_id=(:merchant_id)
  /api/v1/invoices/find?status=(:status)
  /api/v1/invoices/find?created_at=(:created_at)
  /api/v1/invoices/find?updated_at=(:updated_at)

Invoice Items:
  /api/v1/invoice_items/find?id=(:id)
  /api/v1/invoice_items/find?item_id=(:item_id)
  /api/v1/invoice_items/find?invoice_id=(:invoice_id)
  /api/v1/invoice_items/find?quantity=(:quantity)
  /api/v1/invoice_items/find?unit_price=(:unit_price)
  /api/v1/invoice_items/find?created_at=(:created_at)
  /api/v1/invoice_items/find?updated_at=(:updated_at)

Items:
  /api/v1/items/find?id=(:id)
  /api/v1/items/find?name=(:name)
  /api/v1/items/find?description=(:description)
  /api/v1/items/find?merchant_id=(:merchant_id)
  /api/v1/items/find?unit_price=(:unit_price)
  /api/v1/items/find?created_at=(:created_at)
  /api/v1/items/find?updated_at=(:updated_at)

Merchants:
  /api/v1/merchants/find?id=(:id)
  /api/v1/merchants/find?name=(:name)
  /api/v1/merchants/find?created_at=(:created_at)
  /api/v1/merchants/find?updated_at=(:updated_at)

Transactions:
  /api/v1/transactions/find?id=(:id)
  /api/v1/transactions/find?invoice_id=(:invoice_id)
  /api/v1/transactions/find?credit_card_number=(:credit_card_number)
  /api/v1/transactions/find?result=(:result)
  /api/v1/transactions/find?created_at=(:created_at)
  /api/v1/transactions/find?updated_at=(:updated_at)
```

### Multi-Finders

Each data category offers finders to return all objects matching the same search parameters as above. For example,

`/api/v1/merchants/find_all?name=(:name)`

Returns all merchants with the associated name entered at (:name). The "name" search parameter can be replaced with any of the attributes defined on the data type as and accepts parameters as outlined above.


### Relationships

Data collections associated with an individual data object can be requested via nested queries as outlined below. The data object is identified by its ID number at (:id).

#### Merchants

Data collections associated with individual merchants can be accessed via the following paths:

```
/api/v1/merchants/(:id)/items
/api/v1/merchants/(:id)/invoices
```

#### Invoices

Data collections associated with individual invoices can be accessed via the following paths:

```
/api/v1/invoices/(:id)/transactions
/api/v1/invoices/(:id)/invoice_items
/api/v1/invoices/(:id)/items
/api/v1/invoices/(:id)/customer
/api/v1/invoices/(:id)/merchant
```

#### Invoice Items

Data collections associated with individual invoice items can be accessed via the following paths:

```
/api/v1/invoice_items/(:id)/invoice
/api/v1/invoice_items/(:id)/item
```

#### Items

Data collections associated with individual items can be accessed via the following paths:

```
/api/v1/items/(:id)/invoice_items
/api/v1/items/(:id)/merchant
```

#### Transactions

Data collections associated with individual transactions can be accessed via the following paths:

```
/api/v1/transactions/(:id)/invoice
```

#### Customers

Data collections associated with individual customers can be accessed via the following paths:

```
/api/v1/customers/(:id)/invoices
/api/v1/customers/(:id)/transactions
```


### Business Intelligence

Business logic is available as outlined below.


#### Merchants

##### All Merchants

```
Return the top (:x) merchants ranked by total revenue:

`/api/v1/merchants/most_revenue?quantity(:x)`

Returns the top (:x) merchants ranked by total number of items sold:

`/api/v1/merchants/most_items?quantity=(:x)`

Returns the total revenue for date (:x) across all merchants. The dates provided match the format of a standard ActiveRecord timestamp:

`/api/v1/merchants/revenue?date=(:x)`
```


##### A Single Merchant

/api/v1/merchants/:id/revenue returns the total revenue for that merchant across all transactions
/api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
/api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most successful transactions
/api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices
NOTE: Failed charges should never be counted in revenue totals or statistics.

NOTE: All revenues should be reported as a float with two decimal places.

Items

GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated
GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold
GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date
Customers

GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions
Extensions

If you complete the base extensions outlined above, consider one of the following extensions

Build a Client gem

Using the gem, I should be able to interact with all of the endpoints included in the application.

Additional Formats -- CSV

Business people love CSV's. Specifically they love CSV's that they can import into a spreadsheet program and go to town on.

For the business intelligence endpoints in the application, include an option to request the resource as a CSV.

For example I might request top items with this request:

GET /api/v1/items/most_revenue.csv?quantity=x

Which should allow me to download the appropriate data as a CSV file.
