module BigcommerceAPI
  class Hook < Resource
    attr_accessor :id,
                  :store_hash,
                  :client_id,
                  :scope,
                  :headers,
                  :destination,
                  :is_active
  end
end
