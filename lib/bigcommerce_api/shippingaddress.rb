module BigcommerceAPI

  class Shippingaddress < Resource
    attr_accessor :shipping_zone_id, :handling_cost_inc_tax, :city, :company, :handling_cost_tax, :cost_tax_class_id, :zip, :street_1, :items_shipped, :country_iso2, :country, :street_2, :handling_cost_ex_tax, :cost_tax, :order_id, :shipping_zone_name, :handling_cost_tax_class_id, :base_handling_cost, :id, :phone, :last_name, :cost_inc_tax, :base_cost, :shipping_method, :items_total, :cost_ex_tax, :email, :state, :first_name

    belongs_to :shipping_zone, :order

    # this overrides the default method, since this has to come in with an order id
    def resource_url
      "orders/#{self.order_id}/shippingaddresses"
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

    class << self
      	def all(order_id, params={})
          resources = BigcommerceAPI::Base.get("/orders/#{order_id}/shippingaddresses.json", :query => date_adjust(params))
          (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
        end

        def find(order_id, id)
          r = BigcommerceAPI::Base.get("/orders/#{order_id}/shippingaddresses/#{id}.json")
          (r.success? and !r.nil?) ? self.new(r) : nil
        end

    end
  
  end

end