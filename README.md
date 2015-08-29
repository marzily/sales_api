# rales_engine
https://radiant-plateau-5764.herokuapp.com

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


## Endpoints

### Searching

All data objects have the search functionality defined below.
Merchants has been used as an example.

Random

``/api/v1/merchants/random.json`` - returns a random merchant

Show Record

/api/v1/merchants/(:id).json - renders a JSON representation of the appropriate record based on the id number entered at (:id)



Single Finders

Each data category should offer find finders to return a single object representation like this:

GET /api/v1/merchants/find?id=12
Which would find the one merchant with ID 12. The finder should work with any of the attributes defined on the data type and always be case insensitive. For example:

GET /api/v1/merchants/find?name=Schroeder-Jerde
Multi-Finders

Each category should offer find_all finders like this:

GET /api/v1/merchants/find_all?name=Cummings-Thiel
Which would find all the merchants whose name matches this query. The finder should work with any of the attributes defined on the data type and always be case insensitive.

Base Expectations -- Relationships

In addition to the direct queries against single resources, we would like to also be able to pull relationship data from the API.

We'll expose these relationships using nested URLs, as outlined in the sections below.

Merchants

GET /api/v1/merchants/:id/items returns a collection of items associated with that merchant
GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders
Invoices

GET /api/v1/invoices/:id/transactions returns a collection of associated transactions
GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items
GET /api/v1/invoices/:id/items returns a collection of associated items
GET /api/v1/invoices/:id/customer returns the associated customer
GET /api/v1/invoices/:id/merchant returns the associated merchant
Invoice Items

GET /api/v1/invoice_items/:id/invoice returns the associated invoice
GET /api/v1/invoice_items/:id/item returns the associated item
Items

GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items
GET /api/v1/items/:id/merchant returns the associated merchant
Transactions

GET /api/v1/transactions/:id/invoice returns the associated invoice
Customers

GET /api/v1/customers/:id/invoices returns a collection of associated invoices
GET /api/v1/customers/:id/transactions returns a collection of associated transactions
Base Expectations -- Business Intelligence

We want to maintain the original Business Intelligence functionality of SalesEngine, but this time expose the data through our API.

Remember that ActiveRecord is your friend. Much of the complicated logic from your original SalesEngine can be expressed quite succinctly using ActiveRecord queries.

Merchants

All Merchants

GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue
GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold
GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants
Assume the dates provided match the format of a standard ActiveRecord timestamp.

A Single Merchant

GET /api/v1/merchants/:id/revenue returns the total revenue for that merchant across all transactions
GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most successful transactions
GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices
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
