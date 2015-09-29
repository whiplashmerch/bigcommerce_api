module BigcommerceAPI

  class Resource < Base
    attr_accessor :errors

  	def initialize(data)
      self.assign_attributes(data)
      self.attributes_were = data
    end

    def mark_dirty!
      self.attributes_were = {}
      self
    end

    def save
       url = self.resource_url
      if self.id.nil?
        # delete the parent id if there is one
        self.send(self.parent + '_id=', nil) if !self.parent.nil?

        response = BigcommerceAPI::Resource.http_request(:post, "/#{url}", :body => self.attributes(true).to_json)
      else
        # only send updated attributes
        attrs = self.attributes
        body = Hash.new
        self.changed.each{|c| body[c] = attrs[c]}
        response = BigcommerceAPI::Resource.http_request(:put, "/#{url}/#{self.id}", :body => body.to_json)
      end

      return self.id.nil? ? self.class.new(response.parsed_response) : true
    end

    def update_attributes(attributes)
      assign_attributes(attributes) && save
    end

    def assign_attributes(attributes)
      attributes.each do |k, v|
        if v and v.is_a? String
          val = v.gsub(/\n/, '').gsub(/\t/, '').strip
        else
          val = v
        end
        k = "#{k}_hash" if !self.class.has_many_options.nil? and self.class.has_many_options.include? k
        k = "#{k}_resource" if !self.class.has_one_options.nil? and self.class.has_one_options.include? k
        k = "#{self.resource}_#{k}" if k == 'type'
        send(:"#{k}=", val) if self.respond_to? "#{k}="
      end
    end

    def create
      # delete the parent id if there is one
      url = self.resource_url
      self.send(self.parent + '_id=', nil) if !self.parent.nil?

      attrs = self.attributes
      body = Hash.new
      self.changed.each{|c| body[c] = attrs[c]}

      response = BigcommerceAPI::Resource.http_request(:post, "/#{url}", :body => body.to_json)

      return self.class.new(response.parsed_response)
    end

    def delete
      url = self.resource_url
      BigcommerceAPI::Resource.http_request(:delete, "/#{url}/#{self.id}")

      return true
    end

    def find_for_reload
      self.class.find(self.id)
    end

    def reload
      updated = self.find_for_reload
      self.attributes.each do |k, v|
        self.send("#{k}=", updated.send(k))
      end
      return self
    end

    def resource
      self.class.name.downcase.to_s.split('::').last
    end

    def resource_url
      self.class.resource
    end

    def parent
      nil
    end

    def changed
      changed = Array.new
      self.attributes.each do |k, v|
        changed << k if v != attributes_were[k]
      end
      changed -= %w[attributes_were errors]
      return changed
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
            out = BigcommerceAPI::Resource.http_request(:get, "#{self.send(meth + '_hash')['resource']}")
            obj = res.singularize.camelize
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              (out.success? and !out.nil?) ? out.collect{|o| ('BigcommerceAPI::' + obj).constantize.new(o)} : []
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
            out = BigcommerceAPI::Resource.http_request(:get, "#{self.send(meth + '_resource')['resource']}")
            obj = resource.singularize.camelize
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              (out.success? and !out.nil?) ? ('BigcommerceAPI::' + obj).constantize.new(out) : nil
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
            out = BigcommerceAPI::Resource.http_request(:get, "#{url}")
            if out and !defined?('BigcommerceAPI::' + obj).nil?
              (out.success? and !out.nil?) ? ('BigcommerceAPI::' + obj).constantize.new(out) : nil
            end
          end
        end
      end

	  	def resource
	  		out = self.name.split('::').last.downcase
	  		last = out.split(//).last.to_s
        if last == 'y'
          out = out.chomp('y') + 'ies'
	  		elsif last == 's'
	  			out += 'es'
	  		else
	  			out += 's'
	  		end
	  		return out
	  	end

	  	def all(params={})
	      resources = BigcommerceAPI::Resource.http_request(:get, "/#{resource}", :query => date_adjust(params))
	      (resources.success? and !resources.nil?) ? resources.collect{|r| self.new(r)} : []
	    end

	    def find(id)
        r = BigcommerceAPI::Resource.http_request(:get, "/#{resource}/#{id}")
	      (r.success? and !r.nil?) ? self.new(r) : nil
	    end

      def http_request(verb, url, options={})
        begin
          response = BigcommerceAPI::Base.send(verb, url, options)
          if response.code >= 400
            message = parse_errors(response)
            raise BigcommerceAPI::Error.new(response.code, message)
          end
          response
        rescue SocketError => e
          BigcommerceAPI::Result.new(:success => false, :errors => "Invalid URL")
        end
      end

      private

      # recursive function to convert hash into string, e.g. {a: {b: "c"}, d: "e"} becomes "c e"
      def hashToString(hash:, acc: "", delimiter: " ", skip: [])
        if !hash.is_a?(Hash)
          acc += hash.to_s
        else
          hash.map { |k, v|
            if skip.include?(k.to_s)
              ""
            else
              hashToString(hash: v, acc: acc, delimiter: delimiter, skip: skip)
            end
          }.join(delimiter)
        end
      end

      def parse_errors(response)
        e = response  # httparty automatically converts JSON string to hash and array of hash
        e = e.first if e.is_a?(Array) # remove array
        hashToString(hash: e, skip: ["status"])
      end
	  end # end class methods

    private
      attr_accessor :attributes_were

  end

end
