module BigcommerceAPI
  class Order < Resource
    extend BigcommerceAPI::Countable

    attr_accessor :id,
                  :base_handling_cost,
                  :base_shipping_cost,
                  :base_wrapping_cost,
                  :billing_address,
                  :coupon_discount,
                  :coupons_hash,
                  :currency_code,
                  :currency_exchange_rate,
                  :currency_id,
                  :customer_id,
                  :customer_message,
                  :date_created,
                  :date_modified,
                  :date_shipped,
                  :default_currency_code,
                  :default_currency_id,
                  :discount_amount,
                  :geoip_country,
                  :geoip_country_iso2,
                  :gift_certificate_amount,
                  :handling_cost_ex_tax,
                  :handling_cost_inc_tax,
                  :handling_cost_tax,
                  :handling_cost_tax_class_id,
                  :ip_address,
                  :is_deleted,
                  :items_shipped,
                  :items_total,
                  :order_is_digital,
                  :payment_method,
                  :payment_provider_id,
                  :payment_status,
                  :products_hash,
                  :refunded_amount,
                  :shipping_address_count,
                  :shipping_addresses_hash,
                  :shipping_cost_ex_tax,
                  :shipping_cost_inc_tax,
                  :shipping_cost_tax,
                  :shipping_cost_tax_class_id,
                  :staff_notes,
                  :status,
                  :status_id,
                  :store_credit_amount,
                  :subtotal_ex_tax,
                  :subtotal_inc_tax,
                  :subtotal_tax,
                  :total_ex_tax,
                  :total_inc_tax,
                  :total_tax,
                  :wrapping_cost_ex_tax,
                  :wrapping_cost_inc_tax,
                  :wrapping_cost_tax,
                  :wrapping_cost_tax_class_id

    has_many :coupons,
             { products: :order_products },
             :shipping_addresses,
             :shipments
    alias_method :order_line_items, :products
    alias_method :shippingaddresses, :shipping_addresses

    belongs_to :customer,
               :currency,
               :default_currency,
               :shipping_cost_tax_class,
               :wrapping_cost_tax_class,
               :payment_provider,
               :handling_cost_tax_class

    alias_method :old_customer, :customer
    def customer
      old_customer unless customer_id == 0
    end
  end
end
