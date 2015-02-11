module BigcommerceAPI
  class Customer < Resource
    extend BigcommerceAPI::Countable
    attr_accessor :id,
                  :company,
                  :first_name,
                  :last_name,
                  :email,
                  :phone,
                  :date_created,
                  :date_modified,
                  :store_credit,
                  :registration_ip_address,
                  :customer_group_id,
                  :notes

    attr_accessor :addresses_hash

    belongs_to :order
    has_many :addresses
  end
end
