class Api::V1::RestaurantsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    @restaurants = Restaurant.all
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :image, :description)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end
