module BigcommerceAPI

  class Image < Resource
    attr_accessor :id, :image_file, :product_id, :sort_order, :is_thumbnail, :description, :date_created, :standard_url

    belongs_to :product
  
  end

end
