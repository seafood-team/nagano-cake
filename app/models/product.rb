class Product < ApplicationRecord
  

  has_many :order_details
  belongs_to :genre
  
  has_one_attached :image
  scope :price_high_to_low, -> { order(no_tax: :desc) }
  scope :price_low_to_high, -> { order(no_tax: :asc) }

  def with_tax_price
    (no_tax * 1.1).floor
  end
 
  has_many :carts, dependent: :destroy
  
  def get_image
    (image.attached?) ? image : 'no_image.jpg'
  end
  
  with_options presence: true do
  validates :product_name
  validates :introduct
  validates :no_tax
  validates :genre
  end
end
