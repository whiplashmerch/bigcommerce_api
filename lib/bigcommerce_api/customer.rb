module BigcommerceAPI
  class Customer < Resource
    attr_accessor :id

    belongs_to :order
    has_one :address
  end
end
