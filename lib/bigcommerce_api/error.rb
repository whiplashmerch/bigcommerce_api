module BigcommerceAPI
  class Error < StandardError
    attr_reader :code
    def initialize(errors)
      e = errors.first
      @code = e["status"]
      message = e["message"]
      message += " #{e["details"]["conflict_reason"]}" if e["details"]
      super(message)
    end
  end
end
