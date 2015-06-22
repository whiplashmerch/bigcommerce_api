require 'helper'

class BigcommerceAPI::BaseTest < Minitest::Test
  def test_hello_world
    stub_request(:get, "https://api.bigcommerce.com/stores/ABC/v2/orders/1").to_return(body: '{}')
    stub_request(:get, "https://api.bigcommerce.com/stores/DEF/v2/orders/1").to_return(body: '{}')

    BigcommerceAPI::Base.new(store_hash: "ABC", client_id: "ABC", access_token: "ABC")

    Thread.new do
      BigcommerceAPI::Base.new(store_hash: "DEF", client_id: "DEF", access_token: "DEF")
      BigcommerceAPI::Order.find(1)
      asserted_requested_bigcommerce_order("1", "DEF")
    end.join

    BigcommerceAPI::Order.find(1)
    asserted_requested_bigcommerce_order("1", "ABC")
  end

  def asserted_requested_bigcommerce_order(id, token)
    assert_requested(:get,
      "https://api.bigcommerce.com/stores/#{token}/v2/orders/#{id}",
      headers: {
        'X-Auth-Client'=>token,
        'X-Auth-Token' =>token
      }
    )
  end
end
