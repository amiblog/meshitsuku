class Public::RecipesController < ApplicationController
  def new
    @recipe=Recipe.new
  end

  def create
    @recipe=Recipe.new(recipe_params)
    @recipe.customer_id=current_customer.id
    @recipe.save
    redirect_to recipe_path(@recipe.id)
  end

  def index
    @recipes=Recipe.all
  end

  def show
    @recipe=Recipe.find(params[:id])
  end

  def edit
    @recipe=Recipe.find(params[:id])
  end

  def update
    @recipe=Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe.id)
  end

  def destroy
    @recipe=Recipe.find(params[:id])
    @recipe.destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :body, :recipe_image)
  end
end
