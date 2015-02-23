module BigcommerceAPI
  class OptionSetOption < Resource
    attr_accessor :id,
                  :display_name,
                  :is_required,
                  :option_id,
                  :option_resource,
                  :option_set_id,
                  :sort_order

    has_one :option
    belongs_to :option_set

    def resource_url
      "option_sets/#{self.option_set_id}/options"
    end

    def parent
      'option_set'
    end

    def find_for_reload
      self.class.find(self.option_set_id, self.id)
    end

    class << self
      def all(option_set_id, params={})
        resources = BigcommerceAPI::Base.get("/option_sets/#{option_set_id}/options", query: date_adjust(params))
        (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
      end

      def find(option_set_id, id)
        r = BigcommerceAPI::Base.get("/option_sets/#{option_set_id}/options/#{id}")
        (r.success? and !r.nil?) ? self.new(r) : nil
      end
    end
  end
end
