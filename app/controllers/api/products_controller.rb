class Api::ProductsController < ApplicationController
  def show
    product_params = params.permit(:id)
    product = Product.find_by(external_id: product_params[:id])

    red_sky = ApiClients::RedSky.build_red_sky_product(
      product_id: product.external_id
    )

    if product && red_sky && red_sky.valid?
      render json: {
        id: product.external_id,
        name: red_sky.name,
        current_price: {
          value: product.value,
          currency_code: product.currency_code
        }
      }, status: :ok

    else
      render json: {
        errors: {
          message: "product not found",
          product_id: product_id
        }
      }, status: :unprocessable_entity
    end
  end

  def update
  end
end
