module BigcommerceAPI
  class OptionSetOption < Resource
    attr_accessor :id,
                  :display_name,
                  :is_required,
                  :option_id,
                  :option_resource,
                  :option_set_id,
                  :sort_order

    has_one :option
    belongs_to :option_set
  end
end
