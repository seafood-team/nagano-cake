class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def check
    @order = Order.new(order_params)
    # new 画面から渡ってきたデータを @order に入れる
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

  def index

  end

  def show
    @product = Product.find(params[:product_id])
    @order = @product.order.new
  end

  def create
    @product = Product.find(params[:product_id])
    @order = @product.order.new(order_params)
    @order.save
    redirect_to products_path
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :total_price)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

  def order_params
    params.require(:order)
    .permit(:amount,
            :quantity,
            :product_id)
  end
end
