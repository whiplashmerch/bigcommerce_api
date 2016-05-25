module BigcommerceAPI
  class OptionSet < Resource
    attr_accessor :id,
                  :options_hash,
                  :name

    has_many options: :option_set_options
  end
end
