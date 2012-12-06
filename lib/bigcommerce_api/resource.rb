module BigcommerceAPI  

  class Resource < Base

  	def initialize(data)
      data.each do |k, v|
        if v and v.is_a? String
          val = v.gsub(/\n/, '').gsub(/\t/, '').strip
        else
          val = v
        end
        k = "#{k}_hash" if !self.class.has_many_options.nil? and self.class.has_many_options.include? k
        k = "#{k}_resource" if !self.class.has_one_options.nil? and self.class.has_one_options.include? k
        k = "#{self.class.name.downcase.to_s}_#{k}" if k == 'type'
        send(:"#{k}=", val) if self.respond_to? "#{k}="
      end
    end

    def save
      if self.id.nil?
        response = BigcommerceAPI::Base.post("/#{self.class.resource}.json", :body => self.attributes(true).to_json)
      else
        response = BigcommerceAPI::Base.put("/#{self.class.resource}/#{self.id}.json", :body => self.attributes(true).to_json)
      end
      if response.success?
        return self.id.nil? ? self.new(response.parsed_response) : true
      else
        return false
      end
    end

    def create(params={})
      response = BigcommerceAPI::Base.post("/#{self.class.resource}.json", :body => date_adjust(params).to_json)
      if response.success?
        return self.new(response.parsed_response)
      else
        return false
      end
    end

  	class << self
      attr_accessor :has_many_options, :has_one_options, :belongs_to_options

      def has_many(*names)
        self.has_many_options = names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s}
        names.each do |m|
          if m.is_a? Hash
            meth = m.keys.first.to_s
            res = m.values.first.to_s
          else
            meth = m.to_s
            res = m.to_s
          end
          define_method meth do
            out = BigcommerceAPI::Base.get("#{self.send(meth + '_resource')['resource']}.json")
            obj = res.singularize.camelize
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              out.collect{|o| ('BigcommerceAPI::' + obj).constantize.new(o)}
            end
          end
        end
      end

      def has_one(*names)
        self.has_one_options = names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s}
        names.each do |m|
          if m.is_a? Hash
            meth = m.keys.first.to_s
            resource = m.values.first.to_s
          else
            meth = m.to_s
            resource = m.to_s
          end
          define_method meth do
            out = BigcommerceAPI::Base.get("#{self.send(meth + '_hash')['resource']}.json")
            obj = resource.singularize.camelize
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              ('BigcommerceAPI::' + obj).constantize.new(out)
            end
          end
        end
      end
      
      def belongs_to(*names)
        self.belongs_to_options = names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s}
        names.each do |m|
          if m.is_a? Hash
            meth = m.keys.first.to_s
            resource = m.values.first.to_s
          else
            meth = m.to_s
            resource = m.to_s
          end
          define_method meth do
            obj = resource.singularize.camelize
            url = '/' + meth.pluralize + '/' + self.send(meth + "_id").to_s
            out = BigcommerceAPI::Base.get("#{url}.json")
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              return ('BigcommerceAPI::' + obj).constantize.new(out) 
            end
          end
        end
      end

	  	def resource
	  		out = self.name.split('::').last.downcase
	  		last = out.split(//).last(1).to_s
	  		if last == 's'
	  			out += 'es'
	  		else
	  			out += 's'
	  		end
	  		return out
	  	end

	  	def all(params={})
	      resources = BigcommerceAPI::Base.get("/#{resource}.json", :query => date_adjust(params))
	      resources == nil ? [] : resources.collect{|r| self.new(r)}
	    end

	    def find(id)
	      r = BigcommerceAPI::Base.get("/#{resource}/#{id}.json")
	      r == nil ? nil : self.new(r)
	    end
	  end

  end

end