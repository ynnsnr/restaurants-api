class Api::V1::RestaurantController < ActionController::Base
  def index
    @restaurants = Restaurant.all
    return render json: {}
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
