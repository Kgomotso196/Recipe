class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @food = Food.all
  end

  def new
    @user = current_user
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
  end

  def create
    @user = current_user
    @food = current_user.foods.build(food_params)
    @food.user_id = current_user.id
    if @food.save
      redirect_to foods_path(@user), notice: 'Food item was successfully added.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.user == current_user
      @food.destroy
      redirect_to foods_path, notice: 'The food item was successfully deleted!'
    else
      redirect_to foods_path, notice: 'You do not have permission to delete this food item!'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
