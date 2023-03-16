class Public::OrdersController < ApplicationController

  # 購入情報の入力画面で、宛先や住所などを入力するところです
  def new
    @order = Order.new
  end

  # 購入を確定します
  def create # Order に情報を保存します
    carts = current_customer.carts.all
  # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
    @order = current_customer.orders.new(order_params)
  # 渡ってきた値を @order に入れます
    if @order.save
  # ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
      carts.each do |cart|
  # 取り出したカートアイテムの数繰り返します
  # order_item にも一緒にデータを保存する必要があるのでここで保存します
        order_detail = OrderDetail.new
        order_detail.product_id = cart.product_id
        order_detail.order_id = @order.id
        order_detail.order_quantity = cart.quantity
  # 購入が完了したらカート情報は削除するのでこちらに保存します
        order_detail.order_price = cart.product.price
  # カート情報を削除するので item との紐付けが切れる前に保存します
        order_detail.save
      end
      redirect_to 遷移したいページのパス
      cart_items.destroy_all
  # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  # new 画面から渡ってきたデータをユーザーに確認してもらいます
  def check
    @order = Order.new(order_params)
  # new 画面から渡ってきたデータを @order に入れます
    if params[:order][:address_number] == "1"
  # view で定義している address_number が"1"だったときにこの処理を実行します
  # form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
  # この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
      @order.name = current_customer.name # @order の各カラムに必要なものを入れます
      @order.address = current_customer.customer_address
    elsif params[:order][:address_number] == "2"
  # view で定義している address_number が"2"だったときにこの処理を実行します
      if Address.exists?(name: params[:order][:registered])
  # registered は viwe で定義しています
        @order.name = Address.find(params[:order][:registered]).name
        @order.address = Address.find(params[:order][:registered]).address
      else
        render :new
  # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
      end
    elsif params[:order][:address_number] == "3"
  # view で定義している address_number が"3"だったときにこの処理を実行します
      address_new = current_customer.addresses.new(address_params)
      if address_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
      else
        render :new
  # ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
      end
    else
      redirect_to 遷移したいページ # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
    end
    @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
  # 合計金額を出す処理です sum_price はモデルで定義したメソッドです
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :total_price)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end
end
