module BigcommerceAPI

  class OptionSet < Resource
    attr_accessor :id, :name, :options_hash

    has_many :options => :option_set_options
  
  end

end