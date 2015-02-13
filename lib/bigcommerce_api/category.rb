module BigcommerceAPI
  class Category < Resource
    attr_accessor :id,
                  :description,
                  :image_file,
                  :is_visible,
                  :layout_file,
                  :meta_description,
                  :meta_keywords,
                  :name,
                  :page_title,
                  :parent_category_list,
                  :parent_id,
                  :search_keywords,
                  :sort_order,
                  :url
  end
end

