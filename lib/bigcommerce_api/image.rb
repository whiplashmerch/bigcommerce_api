module BigcommerceAPI
  class Image < Resource
    attr_accessor :id,
                  :date_created,
                  :description,
                  :image_file,
                  :is_thumbnail,
                  :product_id,
                  :sort_order,
                  :standard_url,
                  :thumbnail_url,
                  :tiny_url,
                  :zoom_url

    belongs_to :product

    def resource_url
      "products/#{self.product_id}/images"
    end

    def parent
      'product'
    end

    def find_for_reload
      self.class.find(self.product_id, self.id)
    end

    class << self
      def all(product_id, params={})
        resources = BigcommerceAPI::Base.get("/products/#{product_id}/images", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(product_id, id)
        r = BigcommerceAPI::Base.get("/products/#{product_id}/images/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
