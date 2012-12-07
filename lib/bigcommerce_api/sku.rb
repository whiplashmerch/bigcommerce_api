module BigcommerceAPI

  class Sku < Resource
    attr_accessor :id, :sku, :product_id, :cost_price, :upc, :inventory_level, :inventory_warning_level, :bin_picking_number, :options

    belongs_to :product
    
    def product_option_id
      self.options.first['product_option_id']
    end
    
    def option_value_id
      self.options.first['option_value_id']
    end
    
    def product_option
      po = BigcommerceAPI::Base.get '/products/' + self.product_id.to_s + '/options/' + self.product_option_id.to_s + '.json'
      po == nil ? nil : ProductOption.new(po)
    end
    
    def option_value
      option_id = self.product_option.option_id
      ov = BigcommerceAPI::Base.get '/options/' + option_id.to_s + '/values/' + self.option_value_id.to_s + '.json'
      ov == false ? false : OptionValue.new(ov)
    end
    
    def description
      out = Array.new
      po = self.product_option
      ov = self.option_value
      out << po.display_name if po
      out << ov.label if ov
      return out.join(' ')
    end
  
  end

end