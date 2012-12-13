module BigcommerceAPI

  class Shipment < Resource
    attr_accessor :items, :comments, :order_id, :shipping_address, :order_address_id, :id, :tracking_number, :billing_address, :customer_id, :shipping_method, :date_created

    belongs_to :customer, {:order_address => :shipping_address}, :order

    # these are all overrides, since Shipments work a little differently
    def resource_url
      "orders/#{self.order_id}/shipments"
    end

    def save
  	  url = self.resource_url
    	self.order_id = nil

      if self.id.nil?
        response = BigcommerceAPI::Base.post("/#{url}.json", :body => self.attributes(true).to_json)
      else
        response = BigcommerceAPI::Base.put("/#{url}/#{self.id}.json", :body => self.attributes(true).to_json)
      end
      if response.success?
        return self.id.nil? ? self.class.new(response.parsed_response) : true
      else
        self.errors = response.parsed_response
        return false
      end
    end

    def create(params={})
    	url = self.resource_url
    	self.order_id = nil
      response = BigcommerceAPI::Base.post("/#{url}.json", :body => date_adjust(params).to_json)
      if response.success?
        return self.new(response.parsed_response)
      else
        self.errors = response.parsed_response
        return false
      end
    end

    class << self
	  	def all(order_id, params={})
	      resources = BigcommerceAPI::Base.get("/orders/#{order_id}/shipments.json", :query => date_adjust(params))
	      (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
	    end

	    def find(order_id, id)
	      r = BigcommerceAPI::Base.get("/orders/#{order_id}/shipments/#{id}.json")
	      (r.success? and !r.nil?) ? self.new(r) : nil
	    end
	  end
  
  end

end