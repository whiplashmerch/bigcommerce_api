module BigcommerceAPI

  module Countable
    
    def count
      response = BigcommerceAPI::Base.get("/#{resource}/count")
      (response.success? and !response.nil?) ? response['count'] : nil
    end

  end

end

