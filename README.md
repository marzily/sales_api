# Sales API
This project used Ruby on Rails and ActiveRecord to build a JSON API from imported CSV data.
Code Base: https://github.com/aoili/Sales-API
Production Site: http://sales-api.herokuapp.com

##### API Design

* All endpoints return JSON data.
* All endpoints are exposed under an api and version (v1) namespace (e.g. /api/v1/merchants.json).


##### Schema and Data Importing

* ActiveRecord models exist for each entity imported from CSV data. Model objects include: customers, invoices, invoice items, items, merchants, and transactions.
* Application includes custom built rake tasks which import CSV data and create the appropriate records.

```
rake seed:all               # Read all data from CSV to db
rake seed:customer          # Read customer data from CSV to db
rake seed:invoice           # Read invoice data from CSV to db
rake seed:invoice_item      # Read invoice_item data from CSV to db
rake seed:item              # Read item data from CSV to db
rake seed:merchant          # Read merchant data from CSV to db
rake seed:transaction       # Read transaction data from CSV to db
```


## Direct Object Querying

All data objects have the search functionality defined below.
Merchants has been used as an example.

### Random

Return a random merchant:

`/api/v1/merchants/random.json`

### Show Record

Render a JSON representation of the appropriate record based on the ID number entered at (:id):

`/api/v1/merchants/(:id).json`

### Single Finders

Each data category offers finders to return data for a single object by querying one of its attributes. Search parameters are case insensitive. Paths are defined below:

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
  /api/v1/transactions/find?result=(:result)
  /api/v1/transactions/find?created_at=(:created_at)
  /api/v1/transactions/find?updated_at=(:updated_at)
```

### Multi-Finders

Each data category offers finders to return all objects matching the same search parameters as above. For example, the path below returns all merchants with the associated name entered at (:name).

`/api/v1/merchants/find_all?name=(:name)`

 The "name" search parameter can be replaced with any of the attributes defined on the data type and accepts parameters as outlined above.


## Relationships

Data collections associated with an individual data object can be requested via nested queries as outlined below. The data object is identified by its ID number at (:id).

### Customers

Data collections associated with individual customers can be accessed via the following paths:

```
/api/v1/customers/(:id)/invoices
/api/v1/customers/(:id)/transactions
```

### Invoices

Data collections associated with individual invoices can be accessed via the following paths:

```
/api/v1/invoices/(:id)/transactions
/api/v1/invoices/(:id)/invoice_items
/api/v1/invoices/(:id)/items
/api/v1/invoices/(:id)/customer
/api/v1/invoices/(:id)/merchant
```

### Invoice Items

Data collections associated with individual invoice items can be accessed via the following paths:

```
/api/v1/invoice_items/(:id)/invoice
/api/v1/invoice_items/(:id)/item
```

### Items

Data collections associated with individual items can be accessed via the following paths:

```
/api/v1/items/(:id)/invoice_items
/api/v1/items/(:id)/merchant
```

### Merchants

Data collections associated with individual merchants can be accessed via the following paths:

```
/api/v1/merchants/(:id)/items
/api/v1/merchants/(:id)/invoices
```

### Transactions

Data collections associated with individual transactions can be accessed via the following paths:

```
/api/v1/transactions/(:id)/invoice
```


## Business Intelligence

Business logic is available as outlined below.

### Customers

 Return a merchant with whom the customer has conducted the most successful transactions. Customer is identified by ID number:

`/api/v1/customers/(:id)/favorite_merchant`

### Items

Return the top (:x) items ranked by total revenue generated:

`/api/v1/items/most_revenue?quantity=(:x)`

Return the top (:x) item instances ranked by total number sold:

`/api/v1/items/most_items?quantity=(:x)`

Return the date with the most sales for the given item identified by item ID:

`/api/v1/items/(:id)/best_day`


### Merchants

#### All Merchants

Return the top (:x) merchants ranked by total revenue:

`/api/v1/merchants/most_revenue?quantity(:x)`

Returns the top (:x) merchants ranked by total number of items sold:

`/api/v1/merchants/most_items?quantity=(:x)`

#### A Single Merchant

 Return the total revenue for that merchant across all transactions:

`/api/v1/merchants/(:id)/revenue`

 Return the total revenue for that merchant for a specific invoice on date (:x):

`/api/v1/merchants/(:id)/revenue?date=(:x)`

 Return the customer who has conducted the most successful transactions:

`/api/v1/merchants/(:id)/favorite_customer`

Return a collection of customers which have pending (unpaid) invoices:

`/api/v1/merchants/(:id)/customers_with_pending_invoices
`
