require 'test_helper'

class Api::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:my_product)
  end

  test "should fetch product details with a valid product ID" do
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

  test "should return error message when product is not found" do
    get api_product_url(id: 123)
    assert_response :unprocessable_entity
    assert resp = JSON.parse(response.body)

    assert resp.has_key?('errors')
  end

  test "updating the product price via the api" do
    payload = {
      product: {
        id: @product.external_id,
        value: 17.50
      },
      format: :json
    }
    put api_product_url(@product.external_id), params: payload.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
    assert_response :ok
  end
end
