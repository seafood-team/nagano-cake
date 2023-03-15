class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :genre_id, null: false
      t.string :product_name, null: false
      t.text :introduct, null: false
      t.string :no_tax, null: false
      t.string :image_id, null: false
      t.string :sale_status, null: false
      t.timestamps
    end
  end
end
