module BigcommerceAPI
  class Product < Resource
    extend BigcommerceAPI::Countable

    # incoming attributes
    attr_accessor :id,
                  :availability,
                  :availability_description,
                  :bin_picking_number,
                  :brand_id,
                  :categories,
                  :condition,
                  :configurable_fields,
                  :cost_price,
                  :custom_fields,
                  :custom_url,
                  :date_created,
                  :date_last_imported,
                  :date_modified,
                  :depth,
                  :description,
                  :discount_rules,
                  :downloads,
                  :event_date_end,
                  :event_date_field_name,
                  :event_date_start,
                  :event_date_type,
                  :fixed_cost_shipping_price,
                  :height,
                  :inventory_level,
                  :inventory_tracking,
                  :inventory_warning_level,
                  :is_condition_shown,
                  :is_featured,
                  :is_free_shipping,
                  :is_open_graph_thumbnail,
                  :is_preorder_only,
                  :is_price_hidden,
                  :is_visible,
                  :layout_file,
                  :meta_description,
                  :meta_keywords,
                  :myob_asset_account,
                  :myob_expense_account,
                  :myob_income_account,
                  :name,
                  :open_graph_description,
                  :open_graph_title,
                  :open_graph_type,
                  :option_set_display,
                  :option_set_id,
                  :order_quantity_maximum,
                  :order_quantity_minimum,
                  :page_title,
                  :peachtree_gl_account,
                  :preorder_message,
                  :preorder_release_date,
                  :price,
                  :price_hidden_label,
                  :rating_count,
                  :rating_total,
                  :related_products,
                  :retail_price,
                  :sale_price,
                  :search_keywords,
                  :sku,
                  :sort_order,
                  :tax_class_id,
                  :total_sold,
                  :type,
                  :upc,
                  :videos,
                  :view_count,
                  :warranty,
                  :weight,
                  :width

    # has_many
    attr_accessor :options_hash,
                  :skus_hash,
                  :rules_hash,
                  :images_hash

    # has_one
    attr_accessor :option_set_resource,
                  :brand_resource

    # reserved
    attr_accessor :product_type


    has_many :skus,
             :rules,
             :images,
             { options: :product_options }

    has_one :brand,
            :option_set

    belongs_to :tax_class
  end
end
