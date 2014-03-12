module BigcommerceAPI

  class Rule < Resource
    attr_accessor :id, :product_id, :sort_order, :is_enabled, :is_stop, :price_adjuster, :weight_adjuster, 
                  :is_purchasing_disabled, :purchasing_disabled_message, :is_purchasing_hidden, :image_file, 
                  :conditions

    belongs_to :product
  
  end

end