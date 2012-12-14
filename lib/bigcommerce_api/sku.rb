module BigcommerceAPI

  class Sku < Resource
    attr_accessor :id, :sku, :product_id, :cost_price, :upc, :inventory_level, :inventory_warning_level, :bin_picking_number, :options

    belongs_to :product

    def resource_url
      "products/#{self.product_id}/skus"
    end

    def parent
      'product'
    end
    
    def product_option_id
      self.options.first['product_option_id']
    end
    
    def option_value_id
      self.options.first['option_value_id']
    end
    
    def product_option
      po = BigcommerceAPI::Base.get '/products/' + self.product_id.to_s + '/options/' + self.product_option_id.to_s + '.json'
      (po.success? and !po.nil?) ? ProductOption.new(po) : nil
    end
    
    def option_value
      option_id = self.product_option.option_id
      ov = BigcommerceAPI::Base.get '/options/' + option_id.to_s + '/values/' + self.option_value_id.to_s + '.json'
      (ov.success? and !ov.nil?) ? OptionValue.new(ov) : nil
    end
    
    def description
      out = Array.new
      po = self.product_option
      ov = self.option_value
      out << po.display_name if po
      out << ov.label if ov
      return out.join(' ')
    end

    class << self
      def all(product_id, params={})
        resources = BigcommerceAPI::Base.get("/products/#{product_id}/skus.json", :query => date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(product_id, id)
        r = BigcommerceAPI::Base.get("/products/#{product_id}/skus/#{id}.json")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  
  end

end