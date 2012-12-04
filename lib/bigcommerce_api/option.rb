module BigcommerceAPI

  class Option < Resource
    attr_accessor :id, :name, :display_name, :option_type, :values_hash
  
    has_many :values => :option_values
  
  end

end