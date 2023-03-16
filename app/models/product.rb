class Product < ApplicationRecord
  
  
  def with_tax_price
    (no_tax * 1.1).floor
  end
end
