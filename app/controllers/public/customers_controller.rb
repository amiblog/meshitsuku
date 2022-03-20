class Public::CustomersController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :authenticate_customer!, except: [:index]
  before_action :set_customer, only: [:favorites]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer.id != current_customer.id
      redirect_to customers_path
      flash[:alert] = "不正なアクセスです。"
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id)
      flash[:notice] = "更新が完了しました。"
    else
      render :edit
      flash[:alert] = "空欄は無効です。"
    end
  end

  def unsubscribe
  end

  def favorites
    favorites = Favorite.where(customer_id: @customer.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
  end

  def destroy
    @customer = current_customer
    if @customer.destroy
      redirect_to root_path
      flash[:notice] = "退会が完了しました。ご利用ありがとうございました。"
    end
  end

  def search
    @results = @q.result.page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :nickname, :introduction, :profile_image)
  end

  def set_q
    @q = Customer.ransack(params[:q])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
