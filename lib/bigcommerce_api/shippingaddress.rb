module BigcommerceAPI

  class Shippingaddress < Resource
    attr_accessor :shipping_zone_id, :handling_cost_inc_tax, :city, :company, :handling_cost_tax, :cost_tax_class_id, :zip, :street_1, :items_shipped, :country_iso2, :country, :street_2, :handling_cost_ex_tax, :cost_tax, :order_id, :shipping_zone_name, :handling_cost_tax_class_id, :base_handling_cost, :id, :phone, :last_name, :cost_inc_tax, :base_cost, :shipping_method, :items_total, :cost_ex_tax, :email, :state, :first_name

    belongs_to :shipping_zone, :order
  
  end

end