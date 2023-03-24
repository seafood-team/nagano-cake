class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :shipping_addresses
  has_many :orders
  has_many :carts, dependent: :destroy
  
  with_options presence: true do
  validates :last_name
  validates :first_name
  validates :last_name_kana
  validates :first_name_kana
  validates :post_code
  validates :city
  validates :telephone
  validates :email
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end
