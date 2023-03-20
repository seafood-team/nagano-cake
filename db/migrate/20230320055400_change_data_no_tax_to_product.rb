class ChangeDataNoTaxToProduct < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :no_tax, :integer
  end
end
