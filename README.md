# soa_payments
Service for Encapsulating Payment Logic

You can override the database connection string by setting the ENV['DATABASE_URL'].
See the database options on the DataMapper gem site:
http://datamapper.org/getting-started.html

## RabbitMQ
The easiest way to install RabbitMQ is via homebrew.  Run ```brew install rabbitmq```
Make sure to have it running with ```rabbitmq-server```
You may have to source the path in your .bashrc file. ```export PATH="$PATH:/usr/local/sbin"```

## Startup

1. start irb ``` irb ```
2. load app in irb ``` require './app.rb'```
3. create some payment models ``` Payment.create(user_id: 1, amount: 400, status: 'unpaid') ```
4. run the Payment Service ```service = PaymentService.new``` then ```service.init_rpc```
