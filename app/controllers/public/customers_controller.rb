class Public::CustomersController < ApplicationController
  def index
    @customers=Customer.all
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end

  def update
    @customer=Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def unsubscribe

  end

  def destroy
    @customer=current_customer
    @customer.destroy
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :nickname, :introduction, :profile_image)
  end
end
