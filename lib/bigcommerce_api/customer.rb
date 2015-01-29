module BigcommerceAPI
  class Customer < Resource
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

    belongs_to :order
    has_many :addresses
  end
end
