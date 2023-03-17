class Product < ApplicationRecord
  
  has_many :order_details
  
  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

end
