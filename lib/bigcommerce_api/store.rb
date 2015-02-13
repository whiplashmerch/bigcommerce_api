module BigcommerceAPI
  class Store < Base
    attr_accessor :id,
                  :address,
                  :admin_email,
                  :currency,
                  :currency_symbol,
                  :currency_symbol_location,
                  :decimal_places,
                  :decimal_separator,
                  :dimension_units,
                  :domain,
                  :errors,
                  :language,
                  :logo,
                  :name,
                  :order_email,
                  :phone,
                  :plan_name,
                  :thousands_separator,
                  :weight_units

    # Sample response
    # {"id"=>"XXXX", "domain"=>"XXXX.mybigcommerce.com", "name"=>"XXXX", "address"=>"", "phone"=>"", "admin_email"=>"XXX", "order_email"=>"XXX", "language"=>"en", "currency"=>"USD", "currency_symbol"=>"$", "decimal_separator"=>".", "thousands_separator"=>",", "decimal_places"=>2, "currency_symbol_location"=>"left", "weight_units"=>"LBS", "dimension_units"=>"Inches", "plan_name"=>"Partner Sandbox"}
  	def initialize(data)
      data.each do |k, v|
        if v and v.is_a? String
          val = v.gsub(/\n/, '').gsub(/\t/, '').strip
        else
          val = v
        end
        send(:"#{k}=", val) if self.respond_to? "#{k}="
      end
    end
  end
end
