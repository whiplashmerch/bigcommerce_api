module BigcommerceAPI

  class OrderProduct < Resource
    attr_accessor :configurable_fields, :bin_picking_number, :cost_price_ex_tax, :base_total, :name, :fixed_shipping_cost, :price_tax, :price_ex_tax, :refund_amount, :quantity, :price_inc_tax, :product_id, :return_id, :is_refunded, :base_price, :order_id, :option_set_id, :weight, :total_ex_tax, :product_options, :event_name, :wrapping_cost_inc_tax, :wrapping_cost_ex_tax, :order_address_id, :id, :wrapping_message, :base_wrapping_cost, :cost_price_inc_tax, :total_inc_tax, :type, :applied_discounts, :wrapping_name, :cost_price_tax, :base_cost_price, :sku, :parent_order_product_id, :wrapping_cost_tax, :ebay_item_id, :quantity_shipped, :total_tax, :ebay_transaction_id, :event_date, :is_bundled_product, :orderproduct_type
    
    belongs_to :option_set, {:parent_order_product => :order_product}, :ebay_item, :ebay_transaction, :return, :product, :order
  
    def shippingaddress
      a = self.connection.get "/orders/#{self.order_id}/shippingaddresses/#{self.order_address_id}"
      Shippingaddress.new(a, self.connection)
    end
  
  end

end