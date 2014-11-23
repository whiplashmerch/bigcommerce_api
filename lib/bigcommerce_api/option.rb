module BigcommerceAPI
  class Option < Resource
    attr_accessor :id,
                  :display_name,
                  :name,
                  :option_type,
                  :values_hash

    has_many values: :option_values
  end
end
