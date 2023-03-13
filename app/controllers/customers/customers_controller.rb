class CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:update] = "You have updated user info successfully."
      redirect_to customer_path(@customer.id)
    else
      render 'edit'
    end
  end

  def quit
    @customer = current_customer
  end

  def withdraw
  end
  
  private
    def customer_params
        params.require(:customer).permit(:last_name, :first_name,
                                        :last_name_kana, :first_name_kana,
                                        :email, :postcode, :city, :phone_number)
    end

end
