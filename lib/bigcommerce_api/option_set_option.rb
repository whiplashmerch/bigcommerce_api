module BigcommerceAPI

  class OptionSetOption < Resource
    attr_accessor :id, :option_id, :display_name, :option_set_id, :sort_order, :is_required, :option_resource

    has_one :option
    belongs_to :option_set
  
  end

end