class StoresController < InheritedResources::Base
	before_action :authenticate_user!
	before_action :set_store, only: [:show, :edit, :update, :destroy]

	def show
		respond_to do |format|
			format.html
			format.json {render json: @store}
		end
	end

  	private
  		def set_store
  			@store = Store.find(params[:id])
  		end

	    def store_params
	      params.require(:store).permit(:name)
	    end
end

