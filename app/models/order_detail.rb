class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  enum making_status: {
    cannot_make: 0,
    waitinf_for_making: 1,
    making: 2,
    finish_making: 3
  }
  
  def price
    (no_tax * 1.1).floor
  end
  
  def order_subtotal_price
    price.to_i*amount.to_i
  end
  
end
