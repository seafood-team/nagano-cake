class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end

  def show
<<<<<<< HEAD
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
=======
>>>>>>> origin/develop
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer), notice: 'Successfully updated customer status'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:is_deleted, :last_name, :first_name, :first_name_kana, :last_name_kana, :post_code, :city, :telephone)
  end
end
