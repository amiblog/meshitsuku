class Public::CustomersController < ApplicationController
  
  before_action :set_q, only: [:index, :search]
  
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
  
  def search
    @results=@q.result
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :nickname, :introduction, :profile_image)
  end
  
  def set_q
    @q=Customer.ransack(params[:q])
  end
end
