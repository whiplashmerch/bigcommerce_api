module BigcommerceAPI

  class Image < Resource
    attr_accessor :id, :image_file, :product_id, :sort_order, :is_thumbnail, :description, :date_created, :zoom_url, :thumbnail, :standard_url, :tiny_url

    belongs_to :product
  
  end

end
