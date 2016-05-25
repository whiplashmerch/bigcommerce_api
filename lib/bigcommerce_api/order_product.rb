module BigcommerceAPI
  class OrderProduct < Resource
    attr_accessor :id,
                  :applied_discounts,
                  :base_cost_price,
                  :base_price,
                  :base_total,
                  :base_wrapping_cost,
                  :bin_picking_number,
                  :configurable_fields,
                  :cost_price_ex_tax,
                  :cost_price_inc_tax,
                  :cost_price_tax,
                  :ebay_item_id,
                  :ebay_transaction_id,
                  :event_date,
                  :event_name,
                  :fixed_shipping_cost,
                  :is_bundled_product,
                  :is_refunded,
                  :name,
                  :option_set_id,
                  :order_address_id,
                  :order_id,
                  :parent_order_product_id,
                  :price_ex_tax,
                  :price_inc_tax,
                  :price_tax,
                  :product_id,
                  :product_options,
                  :quantity,
                  :quantity_shipped,
                  :refund_amount,
                  :return_id,
                  :sku,
                  :total_ex_tax,
                  :total_inc_tax,
                  :total_tax,
                  :type,
                  :weight,
                  :wrapping_cost_ex_tax,
                  :wrapping_cost_inc_tax,
                  :wrapping_cost_tax,
                  :wrapping_message,
                  :wrapping_name

    belongs_to :option_set,
               { parent_order_product: :order_product },
               :ebay_item,
               :ebay_transaction,
               :return,
               :product,
               :order

    # reserved
    attr_accessor :orderproduct_type

    def shipping_address
      a = BigcommerceAPI::Base.get "/orders/#{self.order_id}/shipping_addresses/#{self.order_address_id}"
      (a.success? and !a.nil?) ? BigcommerceAPI::Shippingaddress.new(a) : nil
    end

    # TODO: these can probably go in a ReadOnly class
    def save
    	self.errors = ["Shipping Addresses are readonly"]
    	return false
    end

    def create(params={})
    	self.errors = ["Shipping Addresses are readonly"]
    	return false
    end

    # this overrides the default method, since this has to come in with an order id
    def resource_url
      "orders/#{self.order_id}/products"
    end

    def parent
      'order'
    end

    def find_for_reload
      self.class.find(self.order_id, self.id)
    end

    class << self
	  	def all(order_id, params={})
	      resources = BigcommerceAPI::Base.get("/orders/#{order_id}/products", query: date_adjust(params))
	      (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
	    end

	    def find(order_id, id)
	      r = BigcommerceAPI::Base.get("/orders/#{order_id}/products/#{id}")
	      (r.success? and !r.nil?) ? self.new(r) : nil
	    end
	  end
  end
end
