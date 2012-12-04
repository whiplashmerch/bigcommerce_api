module BigcommerceAPI

  class OptionValue < Resource
    attr_accessor :id, :option_id, :sort_order, :value, :label
  
    belongs_to :option
  
  end

end