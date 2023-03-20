class ShippingAddress < ApplicationRecord
  belongs_to :customer

  validates :shipping_name,presence:true
  validates :shipping_address,presence:true
  validates :shipping_post_code,presence:true

  def address_display
    '〒' + shipping_post_code + ' ' + shipping_address + ' ' + shipping_name
  end
end
