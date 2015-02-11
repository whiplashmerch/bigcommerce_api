module BigcommerceAPI
  class Address < Resource
    attr_accessor  :id,
                   :customer_id,
                   :first_name,
                   :last_name,
                   :company,
                   :street_1,
                   :street_2,
                   :city,
                   :state,
                   :zip,
                   :country,
                   :country_iso2,
                   :phone,
                   :address_type

    belongs_to :customer

    def resource_url
      "customers/#{self.customer_id}/addresses"
    end

    def parent
      'customer'
    end

    # we override this on resources that need paired IDs for find
    def find_for_reload
      self.class.find(self.customer_id, self.id)
    end

    class << self
      def all(customer_id, params={})
        resources = BigcommerceAPI::Base.get("/customers/#{customer_id}/addresses", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(customer_id, id)
        r = BigcommerceAPI::Base.get("/customers/#{customer_id}/addresses/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
