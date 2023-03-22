class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: {
    credit_card: 0,
    bank_transfer: 1
  }

  enum order_status: {
    payment_waiting: 0,
    payment_confirmation: 1,
    in_production: 2,
    preparing_delivery: 3,
    delivered: 4
  }
  
  def shipping_fee
    800
  end

  # 送料
  def shipping_fee
    800
  end

end
