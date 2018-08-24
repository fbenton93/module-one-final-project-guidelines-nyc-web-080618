# Operating the Sales Database:

This application represents an attempt at a primitive sales database. It's primary
purpose is to READ data that would be seeded through a CSV Importer. As of now,
all data has simply been seeded through the Faker gem.

The app allows management to view global sales figures. It can:
- See local sales data
- See aggregate sales data
- See info about specific product and category sales
- See which customers are shopping at each 'location' the most (by money spent)

The app allows for some, limited CRUD capability. It provides employees the ability
to manually enter in a new purchase record and customer record. It can read info about
purchase data unique to each store and globally. It can update purchase data in the
form of "making an exchange" (an admittedly elementary function), and it can
destroy purchase data in the event a customer has made a return.

Due to some time limitations, we were unable to complete a major function: producing
a full receipt. Each purchase is logged individually, but it tracks store_id, customer_id, product_id
and is timestamped. Using this set of data, unique to a set of purchases, we can group
all purchases made at the same time at the same store by the same customer and represent it
as a full set of purchases.

# Global Data

The global data page allows for the following:
- View total revenue of all stores
- View revenue performance across all card-types
- View all globally available products
- View in-season products
- View all products by category (e.g. 'Outerwear')
- View top selling items
- View highest grossing item
- View all customers in our customers table
- View customers who spend the most

# Local Data
Local data prompts the user to pick a location. Based on their selection, the app
generates an instance of the class from ActiveRecord to operate on. All options in the
local directory run methods that call on this class:

- View store revenue
- View products available at that store
- View local customers who have shopped at that store
- View emails of those customers
- View their highest spending customers
