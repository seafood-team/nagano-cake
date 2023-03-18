class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end

  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_pat
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    @customer.update
  end
  
  
end
