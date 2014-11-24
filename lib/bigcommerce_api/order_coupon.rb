module BigcommerceAPI
  class OrderCoupon < Resource
    attr_accessor :id,
                  :coupon_id,
                  :order_id,
                  :code,
                  :amount,
                  :type,
                  :discount

    belongs_to :order, :coupon
  end
end
