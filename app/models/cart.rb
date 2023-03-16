class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  def sum_price # 税金算出
    product.taxin_price*quantity
  end
end
