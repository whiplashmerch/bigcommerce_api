module BigcommerceAPI

  class Product < Resource
    # incoming attributes
    attr_accessor :brand_id, :myob_expense_account, :inventory_tracking, :preorder_release_date, :tax_class_id, :sku, :date_modified, :fixed_cost_shipping_price, :categories, :meta_description, :sort_order, :related_products, :tax_class, :is_visible, :description, :layout_file, :meta_keywords, :rating_total, :price, :event_date_field_name, :height, :order_quantity_minimum, :myob_asset_account, :order_quantity_maximum, :peachtree_gl_account, :retail_price, :availability_description, :weight, :is_preorder_only, :date_created, :open_graph_title, :rating_count, :open_graph_type, :option_set_id, :is_featured, :date_last_imported, :option_set_display, :availability, :is_condition_shown, :name, :inventory_warning_level, :event_date_end, :cost_price, :inventory_level, :event_date_type, :upc, :open_graph_description, :depth, :custom_url, :myob_income_account, :condition, :is_price_hidden, :custom_fields, :configurable_fields, :discount_rules, :warranty, :total_sold, :view_count, :event_date_start, :price_hidden_label, :videos, :sale_price, :bin_picking_number, :preorder_message, :is_open_graph_thumbnail, :search_keywords, :is_free_shipping, :width, :type, :id, :page_title, :downloads 
    # has_many
    attr_accessor :options_hash, :skus_hash, :rules_hash, :images_hash

    # has_one
    attr_accessor :option_set_resource, :brand_resource

    # reserved 
    attr_accessor :product_type


    has_many :skus, :rules, :images, {:options => :product_options}
    has_one :brand, :option_set
    belongs_to :tax_class
    
  end

end