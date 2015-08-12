class ProducersController < InheritedResources::Base
	before_action :authenticate_user!
	before_action :set_producer, only: [:show, :edit, :update, :destroy]

	def show
		respond_to do |format|
			format.html
			format.json {render json: @producer}
		end
	end

  	private
  		def set_producer
  			@producer = Producer.find(params[:id])
  		end

		def producer_params
			params.require(:producer).permit(:name)
		end
end

