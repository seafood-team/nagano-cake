class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum making_status: {
    cannot_make: 0,
    waitinf_for_making: 1,
    making: 2,
    finish_making: 3
  }

  # def price  #カラムの中の税込価格を計算（わからない）
  #   (no_tax * 1.1).floor
  # end

  # 請求合計
  def billing_sum
    price + shipping_fee
  end

  def order_subtotal_price #税込価格×個数（わからない）
    price.to_i*amount.to_i
  end

end
