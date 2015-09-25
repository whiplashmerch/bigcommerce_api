module BigcommerceAPI
  class Error < StandardError
    attr_reader :code
    def initialize(response)
      @code = response.code
      # use a more verbose error message if available
      super(response.body || response.message)
    end
  end
end
