module BigcommerceAPI
	def has_many(*names)
    class_variable_set(:@@has_many_options, names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s})
    names.each do |m|
      if m.is_a? Hash
        meth = m.keys.first.to_s
        resource = m.values.first.to_s
      else
        meth = m.to_s
        resource = m.to_s
      end
      define_method meth do
        out = BigcommerceAPI::Base.get("/#{self.send(meth + '_hash')['resource']}.json")
        obj = resource.singularize.camelize
        if out and !defined?('BigcommerceAPI::' + obj).nil?
          out.collect{|o| ('BigcommerceAPI::' + obj).constantize.new(o)}
        end
      end
    end
  end

  def has_one(*names)
    class_variable_set(:@@has_one_options, names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s})
    names.each do |m|
      if m.is_a? Hash
        meth = m.keys.first.to_s
        resource = m.values.first.to_s
      else
        meth = m.to_s
        resource = m.to_s
      end
      define_method meth do
        out = self.connection.get self.send(meth + "_resource")['resource']
        obj = resource.singularize.camelize
        if out and !defined?('BigcommerceAPI::' + obj).nil?
          ('BigcommerceAPI::' + obj).constantize.new(out, self.connection)
        end
      end
    end
  end
  
  def belongs_to(*names)
    class_variable_set(:@@belongs_to_options, names.collect{|x| x.is_a?(Hash) ? x.keys.first.to_s : x.to_s})
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
        out = self.connection.get url
        if out and !defined?('BigcommerceAPI::' + obj).nil?
          return ('BigcommerceAPI::' + obj).constantize.new(out, self.connection) 
        end
      end
    end
  end  

  class Resource < Base
  	@@has_many_options = []

  	def initialize(data)
      data.each do |k, v|
        if v and v.is_a? String
          val = v.gsub(/\n/, '').gsub(/\t/, '').strip
        else
          val = v
        end
        k = "#{k}_hash" if defined?(@@has_many_options) and @@has_many_options.include? k
        k = "#{k}_resource" if defined?(@@has_one_options) and @@has_one_options.include? k
        k = "#{self.class.name.downcase.to_s}_#{k}" if k == 'type'
        send(:"#{k}=", val) if self.respond_to? "#{k}="
      end
    end

    def save
      response = BigcommerceAPI::Base.put("/#{self.class.resource}/#{id}.json", :body => self.attributes(true).to_json)
      if response.success?
        return true
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

  		def test
  			puts @@has_many_options.inspect
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
	      resource = BigcommerceAPI::Base.get("/#{resource}/#{id}.json")
	      resource == nil ? nil : self.new(resource)
	    end
	  end

  end

end