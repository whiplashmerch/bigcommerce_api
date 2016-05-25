module BigcommerceAPI
  class ShippingAddress < Resource
    attr_accessor :id,
                  :base_cost,
                  :base_handling_cost,
                  :city,
                  :company,
                  :cost_ex_tax,
                  :cost_inc_tax,
                  :cost_tax,
                  :cost_tax_class_id,
                  :country,
                  :country_iso2,
                  :email,
                  :first_name,
                  :handling_cost_ex_tax,
                  :handling_cost_inc_tax,
                  :handling_cost_tax,
                  :handling_cost_tax_class_id,
                  :items_shipped,
                  :items_total,
                  :last_name,
                  :order_id,
                  :phone,
                  :shipping_method,
                  :shipping_zone_id,
                  :shipping_zone_name,
                  :state,
                  :street_1,
                  :street_2,
                  :zip

    belongs_to :shipping_zone,
               :order

    # this overrides the default method, since this has to come in with an order id
    def resource_url
      "orders/#{self.order_id}/shipping_addresses"
    end

    def parent
      'order'
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

    def find_for_reload
      self.class.find(self.order_id,
        self.id)
    end

    class << self
    	def all(order_id,
        params={})
        resources = BigcommerceAPI::Base.get("/orders/#{order_id}/shipping_addresses", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(order_id,
        id)
        r = BigcommerceAPI::Base.get("/orders/#{order_id}/shipping_addresses/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
