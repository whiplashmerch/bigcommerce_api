module BigcommerceAPI

  class Shipment < Resource
    attr_accessor :items, :comments, :order_id, :shipping_address, :order_address_id, :id, :tracking_number, :billing_address, :customer_id, :shipping_method, :date_created

    belongs_to :customer, {:order_address => :shipping_address}, :order

    # these are all overrides, since Shipments work a little differently
    def resource_url
      "orders/#{self.order_id}/shipments"
    end

    def parent
      'order'
    end

    def find_for_reload
      self.class.find(self.order_id, self.id)
    end

    class << self
	  	def all(order_id, params={})
	      resources = BigcommerceAPI::Base.get("/orders/#{order_id}/shipments", :query => date_adjust(params))
	      (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
	    end

	    def find(order_id, id)
	      r = BigcommerceAPI::Base.get("/orders/#{order_id}/shipments/#{id}")
	      (r.success? and !r.nil?) ? self.new(r) : nil
	    end
	  end
  
  end

end