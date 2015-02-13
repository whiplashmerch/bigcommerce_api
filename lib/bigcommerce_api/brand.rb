module BigcommerceAPI
  class Brand < Resource
    attr_accessor :id,
                  :image_file,
                  :meta_description,
                  :meta_keywords,
                  :name,
                  :page_title,
                  :search_keywords
  end
end

