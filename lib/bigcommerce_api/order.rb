module BigcommerceAPI

  class Order < Resource
    attr_accessor :refunded_amount, :payment_status, :handling_cost_inc_tax, :shipping_cost_ex_tax, :handling_cost_tax, :currency_id, :items_shipped, :handling_cost_ex_tax, :discount_amount, :staff_notes, :default_currency_id, :store_credit_amount, :payment_method, :total_ex_tax, :subtotal_inc_tax, :subtotal_ex_tax, :date_modified, :currency_exchange_rate, :wrapping_cost_inc_tax, :wrapping_cost_ex_tax, :handling_cost_tax_class_id, :base_handling_cost, :id, :is_deleted, :coupon_discount, :customer_message, :geoip_country, :gift_certificate_amount, :total_inc_tax, :base_wrapping_cost, :date_shipped, :billing_address, :geoip_country_iso2, :payment_provider_id, :wrapping_cost_tax_class_id, :base_shipping_cost, :subtotal_tax, :wrapping_cost_tax, :status_id, :customer_id, :default_currency_code, :currency_code, :order_is_digital, :items_total, :total_tax, :shipping_cost_inc_tax, :status, :shipping_address_count, :ip_address, :shipping_cost_tax_class_id, :shipping_cost_tax, :date_created, :products_hash, :shipping_addresses_hash, :coupons_hash
    # :coupons, :shipping_addresses, 

    has_many :coupons, {:products => :order_products}, {:shipping_addresses => :shippingaddresses}
    belongs_to :customer, :currency, :default_currency, :shipping_cost_tax_class, :wrapping_cost_tax_class, :payment_provider, :handling_cost_tax_class
    
    def shipments
      s = BigcommerceAPI::Base.get '/orders/' + self.id.to_s + '/shipments.json'
      s.collect{|o| BigcommerceAPI::Shipment.new(o)}
    end

  end

end