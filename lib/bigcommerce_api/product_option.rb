module BigcommerceAPI

  class ProductOption < Resource
    attr_accessor :id, :display_name, :option_id, :sort_order, :is_required

    belongs_to :option
  
  end

end