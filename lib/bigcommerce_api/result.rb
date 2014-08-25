module BigcommerceAPI  

  class Result < Base
    attr_accessor :errors, :success
    alias_method :success?, :success
    alias_method :parsed_response, :errors

    def errors?
    	(errors and !errors.empty?)
    end

  end
end