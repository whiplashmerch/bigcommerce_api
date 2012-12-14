Bigcommerce API (V2) Client
================================
Full featured Ruby Gem to connect to the Big Commerce API.

Developed and maintained by [Whiplash Merchandising](http://www.whiplashmerch.com).

### Requirements

- Ruby 1.8.7+
- Rubygems
- JSON
- ActiveSupport 2.3.5+
- Httparty

A valid username, API key, and store URL are required to authenticate requests.

### Installation

```
git clone git://github.com/ideaoforder/bigcommerce_api.git
cd bigcommerce_api
rake install
```

Or if you're using Bundler:

```
gem 'bigcommerce_api', '>=0.3.0', :git => 'git://github.com/ideaoforder/bigcommerce_api'
```

### Configuration

To use the API client in your Ruby code, provide the required credentials as follows:

```
require 'rubygems'
require 'bigcommerce_api'

api = BigcommerceAPI::Base.new(
	:api_key => 'XXXXXXXXXXXXX', 
	:username => 'XXXXXXXX', 
	:store_url => 'https://YOUR_STORE.mybigcommerce.com'
)
```
You can test your connection by getting the time

```
 BigcommerceAPI::Base.get_time
```

A valid time means your connection and credentials are good.

### Usage

The API currently gives you read/write access to your all Big Commerce API V2 resources (https://developer.bigcommerce.com/display/API/BigCommerce+API+-+Version+2)

```
$ irb

BigcommerceAPI::Base.new(:api_key => 'XXXXXXXXXXXXX', :username => 'XXXXXXXX', :store_url => 'https://YOUR_STORE.mybigcommerce.com')

products = BigcommerceAPI::Product.all

order = BigcommerceAPI::Order.find(NNN)
order.status_id = 3
if order.save
  puts "success!"
else
  puts order.errors.join('; ')
end

orders = BigcommerceAPI::Order.all(:status_id => 11, :min_date_created => '2008-01-01'})

shipment = BigcommerceAPI::Shipment.create(
	:order_id => bc_order.id, 
	:order_address_id => SHIPMENT_ADDRESS_ID, 
	:tracking_number => 'XXXXXX', 
	:order_date => bc_order.date_created, 
	:items => [{:order_product_id => bc_order_product.id, :quantity => NNN}]
)

```

### Contributing to bigcommerce_api
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2012 Mark Dickson / Whiplash Merchandising. See LICENSE.txt for
further details.

