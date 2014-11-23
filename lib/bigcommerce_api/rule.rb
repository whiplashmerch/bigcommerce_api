module BigcommerceAPI
  class Rule < Resource
    attr_accessor :id,
                  :conditions,
                  :image_file,
                  :is_enabled,
                  :is_purchasing_disabled,
                  :is_purchasing_hidden,
                  :is_stop,
                  :price_adjuster,
                  :product_id,
                  :purchasing_disabled_message,
                  :sort_order,
                  :weight_adjuster

    belongs_to :product
  end
end
