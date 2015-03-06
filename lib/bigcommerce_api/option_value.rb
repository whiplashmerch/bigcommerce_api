module BigcommerceAPI
  class OptionValue < Resource
    attr_accessor :id,
                  :label,
                  :option_id,
                  :sort_order,
                  :value

    belongs_to :option

    def resource_url
      "options/#{self.option_id}/values"
    end

    def parent
      'option'
    end

    def find_for_reload
      self.class.find(self.option_id, self.id)
    end

    class << self
      def all(option_id, params={})
        resources = BigcommerceAPI::Base.get("/options/#{option_id}/values", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(option_id, id)
        r = BigcommerceAPI::Base.get("/options/#{option_id}/values/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
