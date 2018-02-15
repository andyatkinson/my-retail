# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#


[15117729, 16483589, 16696652, 16752456, 15643793, 13860428].each do |external_id|
  Product.find_or_create_by(external_id: external_id)
end

# Add price details
#
Product.find_by(external_id: 13860428).update(
  price_details: {"current_price":{"value": 13.49,"currency_code":"USD"}}
)
