class Product < ApplicationRecord
  

  has_many :order_details
  
  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

  def with_tax_price
    (no_tax * 1.1).floor
  end
 
  has_many :carts, dependent: :destroy
  
  def get_product_image
    (producte_image.attached?) ? product_image : 'no_image.jpg'
  end
  
  with_options presence: true do
  validates :product_name
  validates :introduct
  validates :no_tax
  validates :image
  validates :sale_status
  end
end
