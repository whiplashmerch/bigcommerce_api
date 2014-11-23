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
  end
end
