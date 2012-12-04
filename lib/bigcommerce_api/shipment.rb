module BigcommerceAPI

  class Shipment < Resource
    attr_accessor :items, :comments, :order_id, :shipping_address, :order_address_id, :id, :tracking_number, :billing_address, :customer_id, :shipping_method, :date_created

    belongs_to :customer, {:order_address => :shipping_address}, :order
  
  end

end