class Product < ApplicationRecord
  def value
    # NOTE: in real app, handle these parse issues
    price_details['current_price']['value']
  end

  def currency_code
    # NOTE: in real app, handle these parse issues
    price_details['current_price']['currency_code']
  end
end
