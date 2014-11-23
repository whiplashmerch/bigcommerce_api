module BigcommerceAPI
  class OptionValue < Resource
    attr_accessor :id,
                  :label,
                  :option_id,
                  :sort_order,
                  :value

    belongs_to :option
  end
end
