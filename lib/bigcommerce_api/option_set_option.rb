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

    def resource_url
      "option_sets/#{self.option_set_id}/options"
    end

    def parent
      'option_set'
    end
  end
end
