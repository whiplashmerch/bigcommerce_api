# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: bigcommerce_api 0.6.2 ruby lib

Gem::Specification.new do |s|
  s.name = "bigcommerce_api"
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Dickson"]
  s.date = "2014-08-27"
  s.description = "Enables Ruby applications to communicate with the BigCommerce API V2."
  s.email = "mark@sitesteaders.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "lib/bigcommerce_api.rb",
    "lib/bigcommerce_api/address.rb",
    "lib/bigcommerce_api/base.rb",
    "lib/bigcommerce_api/brand.rb",
    "lib/bigcommerce_api/category.rb",
    "lib/bigcommerce_api/customer.rb",
    "lib/bigcommerce_api/hook.rb",
    "lib/bigcommerce_api/image.rb",
    "lib/bigcommerce_api/inflections.rb",
    "lib/bigcommerce_api/modules/countable.rb",
    "lib/bigcommerce_api/option.rb",
    "lib/bigcommerce_api/option_set.rb",
    "lib/bigcommerce_api/option_set_option.rb",
    "lib/bigcommerce_api/option_value.rb",
    "lib/bigcommerce_api/order.rb",
    "lib/bigcommerce_api/order_product.rb",
    "lib/bigcommerce_api/order_status.rb",
    "lib/bigcommerce_api/product.rb",
    "lib/bigcommerce_api/product_option.rb",
    "lib/bigcommerce_api/resource.rb",
    "lib/bigcommerce_api/result.rb",
    "lib/bigcommerce_api/rule.rb",
    "lib/bigcommerce_api/shipment.rb",
    "lib/bigcommerce_api/shipping_address.rb",
    "lib/bigcommerce_api/sku.rb",
    "lib/bigcommerce_api/store.rb",
    "lib/bigcommerce_api/tax_class.rb"
  ]
  s.homepage = "http://github.com/ideaoforder/bigcommerce_api"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Enables Ruby applications to communicate with the BigCommerce API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end
