class Api::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    product_params = params.permit(:id)
    if product = Product.find_by(external_id: product_params[:id])

      red_sky = ApiClients::RedSky.build_red_sky_product(
        product_id: product.try(:external_id)
      )
    end

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
          product_id: product_params[:id]
        }
      }, status: :unprocessable_entity
    end
  end

  # NOTE: could reply with the same JSON as the show action
  def update
    product_params = params.require(:product).
      permit(:value, :id)

    if product = Product.find_by(external_id: product_params[:id])
      product.value = product_params[:value]
      product.save
      render json: {}, status: :ok
    else

      render json: {
        errors: {
          message: "product not found",
          product_id: product_params[:id]
        }
      }, status: :unprocessable_entity
    end
  end
end
