class Product < ApplicationRecord
  has_many :carts
  has_many :order_details
end
