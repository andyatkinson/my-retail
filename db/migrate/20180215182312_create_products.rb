class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :external_id, null: false, index: true
      t.jsonb :price_details

      t.timestamps
    end
  end
end
