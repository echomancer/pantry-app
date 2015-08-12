class FoodsController < InheritedResources::Base
	load_and_authorize_resource
	before_action :set_food, only: [:show, :edit, :update, :destroy]

	def show
		respond_to do |format|
			format.html
			format.json {render json: @food}
		end
	end

  	private
  		def set_food
  			@food = Food.find(params[:id])
  		end

	    def food_params
	      params.require(:food).permit(:name, :producer_id, :upc, :servings, :serving_size, :unit)
	    end
end

