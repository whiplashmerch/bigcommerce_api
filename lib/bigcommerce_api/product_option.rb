module BigcommerceAPI
  class ProductOption < Resource
    attr_accessor :id,
                  :display_name,
                  :is_required,
                  :option_id,
                  :sort_order

    belongs_to :option
  end
end
