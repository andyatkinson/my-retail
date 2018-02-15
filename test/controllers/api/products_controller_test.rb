require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:my_product)
  end

  test "should get show" do
    get api_product_url(@product.external_id)
    assert_response :success
    assert resp = JSON.parse(response.body)

    assert resp.has_key?('id')
    assert resp.has_key?('name')
    assert resp.has_key?('current_price')

    assert price_details = resp['current_price']
    assert price_details.has_key?('value')
    assert price_details.has_key?('currency_code')
  end
end
