class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  
  def subtotal
    product.with_tax_price * amount
  end
end
