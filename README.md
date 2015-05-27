# soa_payments
Service for Encapsulating Payment Logic

You can override the database connection string by setting the ENV['DATABASE_URL'].
See the database options on the DataMapper gem site:
http://datamapper.org/getting-started.html

## Startup

1. start irb ``` irb ```
2. load app in irb ``` require './app.rb'
3. create some payment models ``` Payment.create(user_id: 1, amount: 400, status: 'unpaid') ```
