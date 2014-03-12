module BigcommerceAPI

  class Category < Resource
    attr_accessor :id, :parent_id, :name, :description, :sort_order, 
                  :page_title, :meta_keywords, :meta_description, 
                  :layout_file, :parent_category_list, :image_file, 
                  :is_visible, :search_keywords, :url

  end

end

