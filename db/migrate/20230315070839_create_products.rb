class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :genre_id, null: false
      t.string :product_name, null: false
      t.text :introduct, null: false
      t.string :no_tax, null: false
      t.boolean :sale_status, null: false, default: true
      t.timestamps
    end
  end
end
