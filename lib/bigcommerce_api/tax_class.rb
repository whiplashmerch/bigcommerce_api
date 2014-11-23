module BigcommerceAPI
  class TaxClass < Resource
    attr_accessor :id,
                  :name

    has_many :products
  end
end
