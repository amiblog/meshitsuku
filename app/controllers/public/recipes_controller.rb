class Public::RecipesController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :authenticate_customer!, except: [:index]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe.id)
      flash[:notice] = "投稿しました。"
    else
      @recipe = Recipe.new
      render :new
      flash[:alert] = "空欄は無効です。"
    end
  end

  def index
    @recipes = Recipe.page(params[:page])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.customer.id != current_customer.id
      redirect_to recipes_path
      flash[:alert] = "不正なアクセスです。"
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe.id)
      flash[:notice] = "更新が完了しました。"
    else
      render :edit
      flash[:alert] = "空欄は無効です。"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
    flash[:notice] = "削除しました。"
  end

  def search
    @results = @q.result.page(params[:page])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :recipe_image)
  end

  def set_q
    @q = Recipe.ransack(params[:q])
  end
end
