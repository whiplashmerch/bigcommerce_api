module BigcommerceAPI
  class Sku < Resource
    attr_accessor :id,
                  :bin_picking_number,
                  :cost_price,
                  :inventory_level,
                  :inventory_warning_level,
                  :options,
                  :product_id,
                  :sku,
                  :upc

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
      po = BigcommerceAPI::Base.get '/products/' + self.product_id.to_s + '/options/' + self.product_option_id.to_s
      (po.success? and !po.nil?) ? ProductOption.new(po) : nil
    end

    def option_value
      po = self.product_option
      if po # we've got to have a product option for this to work
        option_id = po.option_id
        ov = BigcommerceAPI::Base.get '/options/' + option_id.to_s + '/values/' + self.option_value_id.to_s
        (ov.success? and !ov.nil?) ? OptionValue.new(ov) : nil
      else
        return nil
      end
    end

    def description
      out = Array.new
      po = self.product_option
      ov = self.option_value
      out << po.display_name if po
      out << ov.label if ov
      return out.join(' ')
    end

    # we override this on resources that need paired IDs for find
    def find_for_reload
      self.class.find(self.product_id, self.id)
    end

    class << self
      def all(product_id, params={})
        resources = BigcommerceAPI::Base.get("/products/#{product_id}/skus", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(product_id, id)
        r = BigcommerceAPI::Base.get("/products/#{product_id}/skus/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
