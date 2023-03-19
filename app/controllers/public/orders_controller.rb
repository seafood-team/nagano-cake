class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @shipping_address = ShippingAddress.all
  end

  def create # Order に情報を保存

    # ログインユーザーのカートアイテムをすべて取り出して carts に入れる
    carts = current_customer.carts.all
    # 渡ってきた値を @order に入れる
    @order = current_customer.orders.new(order_params)
    if @order.save

      carts.each do |cart|

      # order_details にも一緒にデータを保存する必要があるのでここで保存
        order_details = OrderDetails.new
        order_details.product_id = cart.product_id
        order_details.order_id = @order.id
        # 購入が完了したらカート情報は削除するのでこちらに保存
        order_details.order_amount = cart.amount
        order_details.order_price = cart.product.no_tax

        order_details.save
      end
      redirect_to order_check_path
      # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      cart_products.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def check
    @order = Order.new(order_params)

    if params[:order][:payment_number] == "1"# view で定義している payment_number が"1"だったときにこの処理を実行

      @order.payment_method = 0

    elsif params[:order][:payment_number] == "2"

      @order.payment_method = 1

    else
      redirect_to order_thanks_path
    end
    # new 画面から渡ってきたデータを @order に入れる
    if params[:order][:address_number] == "1"# view で定義している address_number が"1"だったときにこの処理を実行

    # 登録済みの住所を保存
      @order.post_code = current_customer.post_code
      @order.address = current_customer.city
      @order.customer_name = (current_customer.last_name + current_customer.last_name)

    elsif params[:order][:address_number] == "2" # address_number が"2"だったときにこの処理を実行

      if Address.exists?(customer_name: params[:order][:registered])

        # 追加した新しいお届け先を保存
        @order.customer_name = Address.find(params[:order][:registered]).customer_name
        @order.address = Address.find(params[:order][:registered]).address
        @order.post_code = Address.find(params[:order][:registered]).post_code
      else
        render :new
      end
    elsif params[:order][:address_number] == "3"# address_number が"3"だったときにこの処理を実行

      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to order_thanks_path
    end
    @cart_products = current_customer.carts.all # カートアイテムの情報をユーザーに確認してもらうために使用
    @total = @cart_products.inject(0) { |sum, product| sum + product.subtotal }# 合計金額を出す処理です subtotal はモデルで定義したメソッド

  end

  private

  def order_params
    params.require(:order).permit(:customer_name, :address, :shipping_cost)
  end

  def address_params
    params.require(:order).permit(:customer_name, :address)
  end

end
